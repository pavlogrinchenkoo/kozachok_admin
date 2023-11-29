import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kozachok_admin/style.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({this.color, super.key});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Material(
        color: color ?? BC.white,
        borderRadius: BRadius.r12,
        child: InkWell(
          borderRadius: BRadius.r12,
          onTap: () => context.router.pop(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 12, 10),
            child: Row(
              children: [
                Icon(Icons.arrow_back_ios_new, color: BC.primary),
              ],
            ),
          ),
        ),
      )
    ]);
  }
}
