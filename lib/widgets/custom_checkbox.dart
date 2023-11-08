import 'package:flutter/material.dart';
import 'package:kozachok_admin/style.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({super.key, this.value});

  final bool? value;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
            color: value ?? false ? BC.primary : BC.white,
            borderRadius: BRadius.r2,
            border: Border.all(color: BC.primary, width: 1)),
        child: value ?? false ? Icon(Icons.check, color: BC.white) : null);
  }
}
