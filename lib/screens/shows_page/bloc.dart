import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kozachok_admin/api/show/dto.dart';
import 'package:kozachok_admin/api/show/request.dart';
import 'package:kozachok_admin/utils/bloc_base.dart';
import 'package:uuid/uuid.dart';

class ShowsBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final ShowsRequest _request = ShowsRequest();

  ShowsBloc() {
    setState(ScreenState());
  }

  var uuid = const Uuid();

  selectPhoto() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);
    // final ImagePicker picker = ImagePicker();

    if (result != null && result.files.isNotEmpty) {
      final XFile file = XFile.fromData(result.files.first.bytes!,
          name: result.files.first.name);
      setState(currentState.copyWith(photo: file));
    }
  }

  savePhoto(String photoPath, XFile? file) async {
    final storageRef = FirebaseStorage.instance.ref();
    final mountainsRef = storageRef.child('image/$photoPath');

    final b = await file?.readAsBytes();

    await mountainsRef.putData(b!);
  }

  saveAudio(String audioPath, XFile? audio) async {
    final storageRef = FirebaseStorage.instance.ref();
    final mountainsRef = storageRef.child('audio/$audioPath');

    final b = await audio?.readAsBytes();

    await mountainsRef.putData(b!);
  }

  saveShow(TextEditingController controllerTitle,
      TextEditingController controllerDesc) async {
    setState(currentState.copyWith(loading: true));
    final String id = uuid.v1();
    final photoPath = "$id${getFileExtension(currentState.photo?.name)}";
    final audioPath = "$id${getFileExtension(currentState.audio?.name)}";
    await savePhoto(photoPath, currentState.photo);
    await saveAudio(audioPath, currentState.audio);

    await _request.setShows(ShowModel(
        id: id,
        title: controllerTitle.text,
        description: controllerDesc.text,
        date: DateTime.now(),
        photo: photoPath,
        audio: audioPath));

    controllerTitle.clear();
    controllerDesc.clear();
    setState(currentState.clearFiles());
    setState(currentState.copyWith(loading: false));
  }

  selectAudio() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.audio, allowMultiple: false);
    if (result != null && result.files.isNotEmpty) {
      final XFile selFile = XFile.fromData(result.files.first.bytes!,
          name: result.files.first.name);
      setState(currentState.copyWith(audio: selFile));
    }
  }

  String getFileExtension(String? fileName) {
    try {
      return ".${fileName?.split('.').last}";
    } catch (e) {
      return '';
    }
  }

  Future<void> init() async {
    final List<ShowModel> shows = await _request.getShows();
    shows.sort((a, b) => b.date!.compareTo(a.date!));
    setState(currentState.copyWith(shows: shows));
  }

  delete(String? id, BuildContext context) async {
    await _request.delete(id ?? '', context);
    init();
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
