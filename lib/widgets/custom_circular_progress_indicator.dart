import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({required this.color, super.key});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 19,
        height: 19,
        child: CircularProgressIndicator(color: color, strokeWidth: 2),
      ),
    );
  }
}
