import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_downloader_web/image_downloader_web.dart';
import 'package:kozachok_admin/api/storage/request.dart';
import 'package:kozachok_admin/style.dart';
import 'package:kozachok_admin/theme/theme_extensions/app_button_theme.dart';
import 'package:kozachok_admin/widgets/card_elements.dart';
import 'package:kozachok_admin/widgets/spaces.dart';

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
                                    onSave != null
                                        ? onSave?.call()
                                        : () {
                                            print(fields);
                                          };
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
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.field?.title ?? ''),
          Space.w8,
          _AvatarWidget(
              path: widget.field?.imageId,
              onChange: (imageId) => onChangedImageId(imageId)),
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

  onChangedImageId(String? value) {
    widget.field?.imageId = value;
    setState(() {});
  }
}

class _AvatarWidget extends StatefulWidget {
  const _AvatarWidget({
    this.path,
    this.onChange,
  });

  final String? path;
  final void Function(String? imageId)? onChange;

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
        width: 165,
        height: 140,
        decoration:
            BoxDecoration(border: Border.all(width: 1, color: BC.black)),
        child: Row(
          children: [
            Expanded(
                child: image != null
                    ? Image.memory(image!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity)
                    : Container(color: BC.gray)),
            Container(
              color: BC.primary,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        splashRadius: 10,
                        onPressed: () => _downloadPhoto(),
                        icon: Icon(Icons.download, color: BC.white)),
                    // IconButton(
                    //     splashRadius: 10,
                    //     onPressed: () => _uploadPhoto(),
                    //     icon: Icon(Icons.change_circle_outlined,
                    //         color: BC.white)),
                  ]),
            )
          ],
        ));
  }

  Future<void> _loadImage() async {
    if (widget.path == null) return;
    final res = await _storageRequest.getImage(widget.path!);
    if (res == null) return;
    setState(() {
      image = res;
    });
  }

  _downloadPhoto() async {
    if (widget.path == null) return;
    final image = await _storageRequest.getImage(widget.path.toString());

    if (image != null && image.isNotEmpty) {
      await WebImageDownloader.downloadImageFromUInt8List(uInt8List: image);
    }
  }

// _uploadPhoto() async {
//   Uint8List? file = await ImagePickerWeb.getImageAsBytes();
//   XFile xfile = XFile(file?.name);
//
//   widget.onChange(imageRes?.id);
//
//   setState(() {
//     image = file.;
//   });
// }
}

class FieldModel {
  String? title;
  TextEditingController? controller;
  String? imageId;
  bool? value;
  List<dynamic>? values;
  dynamic enumValue;
  FieldType? type;
  bool? enable;
  bool required;

  FieldModel(
      {this.title = '',
      this.controller,
      this.imageId,
      this.value,
      this.values,
      this.enumValue,
      this.type = FieldType.text,
      this.enable = true,
      this.required = false}) {
    if (type == FieldType.text && controller == null) {
      controller = TextEditingController();
    }
  }
}

enum FieldType { checkbox, text, bigText, email, avatar, dropdown, dateTime }