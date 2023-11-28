import 'package:auto_route/auto_route.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_downloader_web/image_downloader_web.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kozachok_admin/api/storage/request.dart';
import 'package:kozachok_admin/style.dart';
import 'package:kozachok_admin/theme/theme_extensions/app_button_theme.dart';
import 'package:kozachok_admin/widgets/card_elements.dart';
import 'package:kozachok_admin/widgets/custom_circular_progress_indicator.dart';
import 'package:kozachok_admin/widgets/spaces.dart';
import 'dart:html' as html;

@RoutePage()
class ChangePage extends StatelessWidget {
  ChangePage({this.fields, this.title, this.onSave, this.widget, super.key});

  final List<FieldModel>? fields;
  final String? title;
  final void Function()? onSave;
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
                Text(
                  title ?? '',
                  style: BS.reg16.apply(color: BC.white),
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
                            child: SizedBox(
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
          _AvatarWidget(field: widget.field, image: widget.field?.imageId),
        ],
      );
    } else if (widget.field?.type == FieldType.audio) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.field?.title ?? ''),
          Space.w8,
          _AudioWidget(field: widget.field, audio: widget.field?.audioId)
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
  });

  final FieldModel? field;
  final String? image;

  @override
  State<_AvatarWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<_AvatarWidget> {
  final StorageRequest _storageRequest = StorageRequest();
  Uint8List? image;

  @override
  void initState() {
    // bytesImage = const Base64Decoder().convert(widget.base64);
    _loadImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints(maxWidth: 380),
        width: double.infinity,
        height: 200,
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
                      )));
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
  final StorageRequest _storageRequest = StorageRequest();
  Uint8List? image;
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    child: Center(child: Text(widget.field?.audioId ?? ''))));
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

  Future saveAudio(String audioPath, XFile? audio) async {
    if (audio == null) return;
    final storageRef = FirebaseStorage.instance.ref();
    final mountainsRef = storageRef.child('audio/$audioPath');

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
  bool? value;
  List<dynamic>? values;
  dynamic enumValue;
  FieldType? type;
  bool? enable;
  bool required;
  String? uuid;

  FieldModel(
      {this.title = '',
      this.controller,
      this.imageId,
      this.audioId,
      this.value,
      this.values,
      this.enumValue,
      this.type = FieldType.text,
      this.enable = true,
      this.required = false,
      this.uuid}) {
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
  audio
}

String getFileExtension(String? fileName) {
  try {
    return ".${fileName?.split('.').last}";
  } catch (e) {
    return '';
  }
}
