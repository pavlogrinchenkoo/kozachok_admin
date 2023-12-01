import 'package:auto_route/auto_route.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kozachok_admin/api/show/dto.dart';
import 'package:kozachok_admin/api/show/request.dart';
import 'package:kozachok_admin/routers/routes.dart';
import 'package:kozachok_admin/utils/bloc_base.dart';
import 'package:kozachok_admin/widgets/chage_page.dart';
import 'package:uuid/uuid.dart';

class ShowsBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final ShowsRequest _request = ShowsRequest();

  ShowsBloc() {
    setState(ScreenState());
  }

  savePhoto(String photoPath, XFile? file) async {
    if (file == null) return;
    final storageRef = FirebaseStorage.instance.ref();
    final mountainsRef = storageRef.child('image/$photoPath');

    final b = await file.readAsBytes();

    await mountainsRef.putData(b);
    return photoPath;
  }

  saveAudio(String audioPath, XFile? audio) async {
    if (audio == null) return;
    final storageRef = FirebaseStorage.instance.ref();
    final mountainsRef = storageRef.child('audio/$audioPath');

    final b = await audio.readAsBytes();

    await mountainsRef.putData(b);
    return audioPath;
  }

  Future<void> init() async {
    setState(currentState.copyWith(loading: true));
    final List<ShowModel> shows = await _request.getShows();
    shows.sort((a, b) => b.date!.compareTo(a.date!));
    setState(currentState.copyWith(shows: shows, loading: false));
  }

  openChange(BuildContext context, ShowModel? item, int i) async {
    final uuid = const Uuid().v1();
    final fields = [
      FieldModel(
        title: 'Title',
        type: FieldType.text,
        required: true,
        controller: TextEditingController(text: item?.title),
      ),
      FieldModel(
        title: 'Description',
        type: FieldType.text,
        required: true,
        controller: TextEditingController(text: item?.description),
      ),
      FieldModel(
          title: 'Image',
          uuid: item?.id ?? uuid,
          type: FieldType.avatar,
          imageId: item?.photo),
      FieldModel(
          title: 'Audio',
          uuid: item?.id ?? uuid,
          type: FieldType.audio,
          audioId: item?.audio),
    ];

      context.router
          .push(ChangeRoute(
              fields: fields,
              title: 'Show',
              onSave: () => {
                    onSave(context, fields, item, i,
                        isCreate: item?.id == null, newUuid: uuid),
                  }))
          .whenComplete(() => init());
  }

  onSave(BuildContext context, List<FieldModel> fields, ShowModel? item, int i,
      {bool isCreate = false, String? newUuid}) async {
    final newModel = ShowModel(
        title: fields.firstWhere((i) => i.title == 'Title').controller?.text,
        description:
            fields.firstWhere((i) => i.title == 'Description').controller?.text,
        photo: fields.firstWhere((i) => i.title == 'Image').imageId,
        audio: fields.firstWhere((i) => i.title == 'Audio').audioId,
        id: item?.id,
        date: item?.date ?? DateTime.now());

    if (isCreate) {
      onCreate(context, newModel, i, newUuid ?? '');
      return;
    }
    final res = await _request.update(newModel);
    replaceItem(res, newModel, i);
    if (context.mounted) context.router.pop();
  }

  void replaceItem(ShowModel changed, ShowModel newVariable, int i) {
    if (changed.id == null) return;
    final shows = [...currentState.shows];
    if (i == -1) {
      newVariable
        ..id = changed.id
        ..date = changed.date;
      shows.add(newVariable);
    } else {
      shows.replaceRange(i, i + 1, [changed]);
    }
    setState(currentState.copyWith(shows: shows));
  }

  Future<void> onCreate(
      BuildContext context, ShowModel newModel, int i, String newUuid) async {
    final requestModel = ShowModel(
        title: newModel.title,
        audio: newModel.audio,
        description: newModel.description,
        photo: newModel.photo,
        date: newModel.date,
        id: newUuid);

    final res = await _request.create(requestModel);
    replaceItem(res, newModel, i);
    if (context.mounted) context.router.pop();
  }

  getPhoto(String photoPath) async {
    final storageRef = FirebaseStorage.instance.ref();
    final mountainsRef = storageRef.child('image/$photoPath');
    final photo = await mountainsRef.getData();
    final xFile = XFile.fromData(photo!, name: photoPath);
    return xFile;
  }

  getAudio(String audioPath) async {
    if (audioPath.isEmpty) return null;
    final storageRef = FirebaseStorage.instance.ref();
    final mountainsRef = storageRef.child('audio/$audioPath');
    final audio = await mountainsRef.getData(314572800);
    final xFile = XFile.fromData(audio!, name: audioPath);
    return xFile;
  }
}

class ScreenState {
  final bool loading;
  final List<dynamic> images;
  final List<ShowModel> shows;
  final XFile? photo;
  final XFile? audio;

  ScreenState(
      {this.loading = false,
      this.images = const [],
      this.shows = const [],
      this.photo,
      this.audio});

  ScreenState copyWith(
      {bool? loading,
      List<dynamic>? images,
      List<ShowModel>? shows,
      XFile? photo,
      XFile? audio}) {
    return ScreenState(
        loading: loading ?? this.loading,
        images: images ?? this.images,
        shows: shows ?? this.shows,
        photo: photo ?? this.photo,
        audio: audio ?? this.audio);
  }

  ScreenState clearFiles() {
    return ScreenState(
      loading: loading,
      photo: null,
      audio: null,
    );
  }
}
