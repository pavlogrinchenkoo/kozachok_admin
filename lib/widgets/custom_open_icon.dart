import 'package:flutter/material.dart';
import 'package:kozachok_admin/style.dart';

class CustomOpenIcon extends StatelessWidget {
  const CustomOpenIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(color: BC.primary, borderRadius: BRadius.r6),
        child: Icon(Icons.open_in_new, color: BC.white));
  }
}
