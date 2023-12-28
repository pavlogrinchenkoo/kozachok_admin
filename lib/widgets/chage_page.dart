import 'package:auto_route/auto_route.dart';
import 'package:crop/crop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_downloader_web/image_downloader_web.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kozachok_admin/style.dart';
import 'package:kozachok_admin/theme/theme_extensions/app_button_theme.dart';
import 'package:kozachok_admin/widgets/app_bar_back_button.dart';
import 'package:kozachok_admin/widgets/card_elements.dart';

// import 'package:kozachok_admin/widgets/crop/crop_your_image.dart';
import 'package:kozachok_admin/widgets/custom_button.dart';
import 'package:kozachok_admin/widgets/custom_circular_progress_indicator.dart';
import 'package:kozachok_admin/widgets/spaces.dart';

@RoutePage()
class ChangePage extends StatelessWidget {
  ChangePage(
      {this.fields,
      this.title,
      this.onSave,
      this.onDelete,
      this.widget,
      super.key});

  final List<FieldModel>? fields;
  final String? title;
  final void Function()? onSave;
  final void Function()? onDelete;
  final Widget? widget;

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    fields?.sort((a, b) => a.type == FieldType.checkbox ? 1 : -1);
    fields?.sort((a, b) => a.type == FieldType.bigText ? 1 : -1);

    if ((fields ?? []).any((field) => field.type == FieldType.avatar)) {
      fields?.sort((a, b) => a.type == FieldType.avatar ? 1 : -1);
    }

    return Scaffold(
      body: SizedBox(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (title != null)
                Row(
                  children: [
                    const AppBarBackButton(),
                    Space.w16,
                    Text(
                      title ?? '',
                      style: BS.reg16.apply(color: BC.white),
                    ),
                  ],
                ),
              Space.h32,
              CardBody(
                  padding: EdgeInsets.zero,
                  child: FormBuilder(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Wrap(spacing: 16, children: [
                        for (final field in fields ?? [])
                          Container(
                            width: 400,
                            padding: const EdgeInsets.only(top: 24),
                            child: CustomFieldWidget(field: field),
                          ),
                        widget ?? const SizedBox(),
                        Padding(
                          padding: const EdgeInsets.only(top: 36),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 36.0,
                                  width: 100.0,
                                  child: ElevatedButton(
                                    style: themeData
                                        .extension<AppButtonTheme>()!
                                        .primaryElevated,
                                    onPressed: () {
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        // Validation passed.
                                        onSave != null ? onSave?.call() : () {};
                                      } else {
                                        // Validation failed.
                                      }
                                    },
                                    child: const Text('Save'),
                                  ),
                                ),
                                Space.w22,
                                if (onDelete != null)
                                  SizedBox(
                                    height: 36.0,
                                    width: 100.0,
                                    child: ElevatedButton(
                                      style: themeData
                                          .extension<AppButtonTheme>()!
                                          .primaryElevated,
                                      onPressed: () {
                                        onDelete?.call();
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ]))),
              // Space.h24,
            ]),
            // Center(
            //     child: SizedBox(
            //         width: 400,
            //         child: CustomButton(title: 'Save', onTap: onSave))),
          ],
        ),
      ),
    );
  }
}

class CustomFieldWidget extends StatefulWidget {
  const CustomFieldWidget({this.field, super.key});

  final FieldModel? field;

  @override
  State<CustomFieldWidget> createState() => _CustomFieldWidgetState();
}

class _CustomFieldWidgetState extends State<CustomFieldWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.field?.type == FieldType.text) {
      return FormBuilderTextField(
        controller: widget.field?.controller,
        enabled: widget.field?.enable ?? true,
        name: widget.field?.title ?? '',
        decoration: InputDecoration(
          labelText: widget.field?.title ?? '',
          hintText: widget.field?.title ?? '',
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        validator: (widget.field?.required ?? false)
            ? FormBuilderValidators.required()
            : null,
      );
    } else if (widget.field?.type == FieldType.bigText) {
      return FormBuilderTextField(
        minLines: 10,
        maxLines: 10,
        controller: widget.field?.controller,
        enabled: widget.field?.enable ?? true,
        name: widget.field?.title ?? '',
        decoration: InputDecoration(
          labelText: widget.field?.title ?? '',
          hintText: widget.field?.title ?? '',
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        validator: (widget.field?.required ?? false)
            ? FormBuilderValidators.required()
            : null,
      );
    } else if (widget.field?.type == FieldType.checkbox) {
      return FormBuilderCheckbox(
        checkColor: BC.white,
        activeColor: BC.primary,
        name: widget.field?.title ?? '',
        enabled: widget.field?.enable ?? true,
        initialValue: widget.field?.value ?? false,
        onChanged: (value) => onChanged(value ?? false),
        title: Text(widget.field?.title ?? ''),
        validator: FormBuilderValidators.required(),
      );
    } else if (widget.field?.type == FieldType.email) {
      return FormBuilderTextField(
        controller: widget.field?.controller,
        enabled: widget.field?.enable ?? true,
        name: widget.field?.title ?? '',
        decoration: InputDecoration(
          labelText: widget.field?.title ?? '',
          hintText: widget.field?.title ?? '',
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        validator: (widget.field?.required ?? false)
            ? FormBuilderValidators.email()
            : null,
      );
    } else if (widget.field?.type == FieldType.dateTime) {
      return FormBuilderDateTimePicker(
        name: widget.field?.title ?? '',
        onChanged: (DateTime? value) {
          if (value != null) {
            widget.field?.controller?.text = (value).toIso8601String();
          }
        },
        inputType: InputType.date,
        decoration: InputDecoration(
          labelText: widget.field?.title ?? '',
          border: const OutlineInputBorder(),
        ),
        initialValue: widget.field?.controller?.text != null &&
                widget.field?.controller?.text != ''
            ? DateTime.parse(widget.field?.controller?.text ?? '')
            : DateTime.now(),
      );
    } else if (widget.field?.type == FieldType.avatar) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.field?.title ?? ''),
          Space.w8,
          _AvatarWidget(
              field: widget.field,
              image: widget.field?.imageId,
              context: context),
        ],
      );
    } else if (widget.field?.type == FieldType.audio) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.field?.title ?? ''),
          Space.w8,
          _AudioWidget(field: widget.field, audio: widget.field?.audioId),
        ],
      );
    } else if (widget.field?.type == FieldType.video) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.field?.title ?? ''),
          Space.w8,
          _VideoWidget(field: widget.field, audio: widget.field?.videoId),
        ],
      );
    } else if (widget.field?.type == FieldType.dropdown) {
      return FormBuilderDropdown(
        name: widget.field?.title ?? '',
        decoration: InputDecoration(
          labelText: widget.field?.title ?? '',
          border: const OutlineInputBorder(),
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
        ),
        focusColor: Colors.transparent,
        onChanged: (value) => widget.field?.enumValue = value,
        validator: FormBuilderValidators.required(),
        initialValue: widget.field?.enumValue,
        items: (widget.field?.values ?? [])
            .map((e) => DropdownMenuItem(
                value: e, child: Text(e.toString().split('.').last)))
            .toList(),
      );
    } else {
      return const SizedBox();
    }
  }

  onChanged(bool value) {
    widget.field?.value = value;
    setState(() {});
  }

// onChangedImageId(XFile? file) {
//   widget.field?.image = file;
//   setState(() {});
// }

// onChangedAudio(XFile? file) {
//   widget.field?.audio = file;
//   setState(() {});
// }
}

class _AvatarWidget extends StatefulWidget {
  const _AvatarWidget({
    this.field,
    this.image,
    this.context,
  });

  final FieldModel? field;
  final String? image;
  final BuildContext? context;

  @override
  State<_AvatarWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<_AvatarWidget> {
  late DropzoneViewController controller;
  bool isHighlighted = false;
  Uint8List? image;

  @override
  void initState() {
    // bytesImage = const Base64Decoder().convert(widget.base64);
    _loadImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            constraints: const BoxConstraints(maxWidth: 400),
            width: double.infinity,
            height: (widget.field?.isShow ?? false) ? 400 : 300,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: BC.primary),
              borderRadius: BorderRadius.circular(10),
            ),
            child: widget.field?.imageId == null
                ? InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () => _uploadPhoto(),
                    child: const Center(child: Icon(Icons.add)))
                : InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () => _uploadPhoto(),
                    child: image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.memory(image!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: BC.gray,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ))),
        Space.h8,
        if (image?.isNotEmpty ?? false)
          InkWell(
              onTap: () => _downloadPhoto(image, widget.field?.imageId ?? ''),
              child: Text('Download photo',
                  style: BS.reg16.apply(
                      decoration: TextDecoration.underline, color: BC.white))),
        // Stack(
        //   children: [
        //     const Padding(
        //       padding: EdgeInsets.only(right: 16),
        //       child: CustomButton(
        //         text: 'Move here',
        //       ),
        //     ),
        //     Positioned(
        //       top: 0,
        //       left: 0,
        //       right: 0,
        //       bottom: 0,
        //       child: DropzoneView(
        //         onDrop: _uploadPhotoDrag,
        //         onHover: () => setState(() => isHighlighted = true),
        //         onLeave: () => setState(() => isHighlighted = false),
        //         onCreated: (controller) => this.controller = controller,
        //       ),
        //     ),
        //   ],
        // )
      ],
    );
  }

  Future<void> _loadImage() async {
    if (widget.image == null) return;
    final image = await getPhoto(widget.field?.imageId ?? '');
    setState(() {
      this.image = image;
    });
  }

  Future<Uint8List> getPhoto(String photoPath) async {
    final storageRef = FirebaseStorage.instance.ref();
    final mountainsRef = storageRef.child('image/$photoPath');
    final photo = await mountainsRef.getData();
    final xFile = XFile.fromData(photo!, name: photoPath);
    return await xFile.readAsBytes();
  }

  _downloadPhoto(Uint8List? image, String? name) async {
    if (image?.isNotEmpty ?? false) {
      await WebImageDownloader.downloadImageFromUInt8List(
          uInt8List: image!, name: 'photo_$name');
    }
  }

  _uploadPhoto() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);
    if (result != null) {
      final bytes = result.files.first.bytes;
      final photoPath =
          "${widget.field?.uuid}${getFileExtension(result.files.first.name)}";

      final xFile = XFile.fromData(bytes!, name: photoPath);
      savePhoto(photoPath, xFile);
      widget.field?.imageId = photoPath;
      // widget.onChange!(xFile
      // );
      setState(() {
        image = bytes;
      });
    }
  }

  Future<void> _uploadPhotoDrag(dynamic event) async {
    final name = event.name;
    Uint8List? bytes = await controller.getFileData(event);

    final photoPath = "${widget.field?.uuid}${getFileExtension(name)}";

    final xFile = XFile.fromData(bytes!, name: photoPath);
    savePhoto(photoPath, xFile);
    widget.field?.imageId = photoPath;
    // widget.onChange!(xFile
    // );
    setState(() {
      image = bytes;
    });
  }

  savePhoto(String photoPath, XFile? file) async {
    if (file == null) return;
    final storageRef = FirebaseStorage.instance.ref();
    final mountainsRef = storageRef.child('image/$photoPath');

    final b = await file.readAsBytes();

    await mountainsRef.putData(b);
    return photoPath;
  }
}

class _AudioWidget extends StatefulWidget {
  const _AudioWidget({
    this.field,
    this.audio,
  });

  final FieldModel? field;
  final String? audio;

  @override
  State<_AudioWidget> createState() => _AudioWidgetState();
}

class _AudioWidgetState extends State<_AudioWidget> {
  Uint8List? image;
  late DropzoneViewController controller;
  bool isHighlighted = false;
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            constraints: const BoxConstraints(maxWidth: 400),
            width: double.infinity,
            height: 140,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: BC.primary),
              borderRadius: BorderRadius.circular(10),
            ),
            child: loading
                ? CustomCircularProgressIndicator(color: BC.primary)
                : widget.field?.audioId == null
                    ? InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () => _uploadAudio(),
                        child: const Center(child: Icon(Icons.add)))
                    : InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () => _uploadAudio(),
                        child:
                            Center(child: Text(widget.field?.audioId ?? '')))),
        // Space.h8,
        // Stack(
        //   children: [
        //     CustomButton(
        //       text: 'Move here',
        //     ),
        //     Positioned(
        //       top: 0,
        //       left: 0,
        //       right: 0,
        //       bottom: 0,
        //       child: DropzoneView(
        //         onDrop: _uploadPhotoDrag,
        //         onHover: () => setState(() => isHighlighted = true),
        //         onLeave: () => setState(() => isHighlighted = false),
        //         onCreated: (controller) => this.controller = controller,
        //       ),
        //     ),
        //   ],
        // )
      ],
    );
  }

  _uploadAudio() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.audio, allowMultiple: false);
    if (result != null) {
      setState(() {
        loading = true;
      });
      final bytes = result.files.first.bytes;
      final audioPath =
          "${widget.field?.uuid}${getFileExtension(result.files.first.name)}";

      final xFile = XFile.fromData(bytes!, name: audioPath);
      await saveAudio(audioPath, xFile);
      widget.field?.audioId = audioPath;
      // widget.onChange!(xFile
      // );
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> _uploadPhotoDrag(dynamic event) async {
    setState(() {
      loading = true;
    });

    final name = event.name;
    Uint8List? bytes = await controller.getFileData(event);

    final audioPath = "${widget.field?.uuid}${getFileExtension(name)}";

    final xFile = XFile.fromData(bytes, name: audioPath);
    await saveAudio(audioPath, xFile);
    widget.field?.audioId = audioPath;
    setState(() {
      image = bytes;
      loading = false;
    });
  }

  Future saveAudio(String audioPath, XFile? audio) async {
    if (audio == null) return;
    final storageRef = FirebaseStorage.instance.ref();
    final mountainsRef = storageRef.child('audio/$audioPath');

    final b = await audio.readAsBytes();

    await mountainsRef.putData(b);
    return audioPath;
  }
}

class _VideoWidget extends StatefulWidget {
  const _VideoWidget({
    this.field,
    this.audio,
  });

  final FieldModel? field;
  final String? audio;

  @override
  State<_VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<_VideoWidget> {
  late DropzoneViewController controller;
  bool isHighlighted = false;
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            constraints: const BoxConstraints(maxWidth: 400),
            width: double.infinity,
            height: 140,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: BC.primary),
              borderRadius: BorderRadius.circular(10),
            ),
            child: loading
                ? CustomCircularProgressIndicator(color: BC.primary)
                : widget.field?.videoId == null
                    ? InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () => _uploadVideo(),
                        child: const Center(child: Icon(Icons.add)))
                    : InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () => _uploadVideo(),
                        child:
                            Center(child: Text(widget.field?.videoId ?? '')))),
        Space.h8,
        Stack(
          children: [
            CustomButton(
              text: 'Move here',
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: DropzoneView(
                onDrop: _uploadPhotoDrag,
                onHover: () => setState(() => isHighlighted = true),
                onLeave: () => setState(() => isHighlighted = false),
                onCreated: (controller) => this.controller = controller,
              ),
            ),
          ],
        )
      ],
    );
  }

  _uploadVideo() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.audio, allowMultiple: false);
    if (result != null) {
      setState(() {
        loading = true;
      });
      final bytes = result.files.first.bytes;
      final videoPath =
          "${widget.field?.uuid}${getFileExtension(result.files.first.name)}";

      final xFile = XFile.fromData(bytes!, name: videoPath);
      await saveVideo(videoPath, xFile);
      widget.field?.videoId = videoPath;
      // widget.onChange!(xFile
      // );
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> _uploadPhotoDrag(dynamic event) async {
    setState(() {
      loading = true;
    });

    final name = event.name;
    Uint8List? bytes = await controller.getFileData(event);

    final audioPath = "${widget.field?.uuid}${getFileExtension(name)}";

    final xFile = XFile.fromData(bytes, name: audioPath);
    await saveVideo(audioPath, xFile);
    widget.field?.videoId = audioPath;
    setState(() {
      loading = false;
    });
  }

  Future saveVideo(String audioPath, XFile? audio) async {
    if (audio == null) return;
    final storageRef = FirebaseStorage.instance.ref();
    final mountainsRef = storageRef.child('video/$audioPath');

    final b = await audio.readAsBytes();

    await mountainsRef.putData(b);
    return audioPath;
  }
}

class FieldModel {
  String? title;
  TextEditingController? controller;
  String? imageId;
  String? audioId;
  String? videoId;
  bool? value;
  List<dynamic>? values;
  dynamic enumValue;
  FieldType? type;
  bool? enable;
  bool required;
  String? uuid;
  bool? isShow;

  FieldModel(
      {this.title = '',
      this.controller,
      this.imageId,
      this.audioId,
      this.videoId,
      this.value,
      this.values,
      this.enumValue,
      this.type = FieldType.text,
      this.enable = true,
      this.required = false,
      this.uuid,
      this.isShow}) {
    if (type == FieldType.text && controller == null) {
      controller = TextEditingController();
    }
  }
}

enum FieldType {
  checkbox,
  text,
  bigText,
  email,
  avatar,
  dropdown,
  dateTime,
  audio,
  video
}

String getFileExtension(String? fileName) {
  try {
    return ".${fileName?.split('.').last}";
  } catch (e) {
    return '';
  }
}

cropFile(imageFile, BuildContext context) async {
  return await ImageCropper().cropImage(
    sourcePath: imageFile.path,
    aspectRatioPresets: [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9
    ],
    uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      IOSUiSettings(
        title: 'Cropper',
      ),
      WebUiSettings(
        context: context,
      ),
    ],
  );
}

Future<Uint8List?> _showCropper(
    BuildContext context, PlatformFile? file) async {
  final controller = CropController();
  BoxShape shape = BoxShape.rectangle;
  return await showGeneralDialog(
      context: context,
      barrierColor: Colors.black12.withOpacity(0.6),
      // Background color
      barrierDismissible: false,
      barrierLabel: 'Dialog',
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, __, ___) {
        return Column(
          children: [
            // Expanded(
            //   child: Crop(
            //       image: file?.bytes ?? Uint8List(0),
            //       controller: controller,
            //       aspectRatio: 372 / 216,
            //       fixAspectRatio: false,
            //       onCropped: (image) {
            //         context.router.pop(image);
            //       }),
            // ),
            Crop(
              onChanged: (decomposition) {},
              controller: controller,
              shape: shape,
              /* It's very important to set `fit: BoxFit.cover`.
                   Do NOT remove this line.
                   There are a lot of issues on github repo by people who remove this line and their image is not shown correctly.
                */
              foreground: IgnorePointer(
                child: Container(
                  alignment: Alignment.bottomRight,
                  child: const Text(
                    'Foreground Object',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              helper: shape == BoxShape.rectangle
                  ? Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    )
                  : null,
              child: Image.asset(
                'images/sample.jpg',
                fit: BoxFit.cover,
              ),
            ),
            ElevatedButton(child: Text('Crop it!'), onPressed: () => {}),
          ],
        );
      }).then((value) async {
    return value as Uint8List?;
  });
}
