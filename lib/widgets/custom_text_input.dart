import 'package:flutter/material.dart';
import 'package:kozachok_admin/style.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput({this.controller, this.focus, this.label, super.key});

  final TextEditingController? controller;
  final FocusNode? focus;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focus,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: BS.med20.apply(color: BC.white),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: BC.primary),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: BC.primary),
        ),
      ),
      style: BS.reg16.apply(color: BC.white),
      cursorColor: BC.primary,
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 5,
    );
  }
}
