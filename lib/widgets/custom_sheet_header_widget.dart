import 'package:flutter/material.dart';
import 'package:kozachok_admin/style.dart';
import 'package:kozachok_admin/theme/theme_extensions/app_button_theme.dart';
import 'package:kozachok_admin/utils/constants/dimens.dart';
import 'package:kozachok_admin/widgets/spaces.dart';

class CustomSheetHeaderWidget extends StatelessWidget {
  const CustomSheetHeaderWidget({this.title, this.onSave, super.key});

  final String? title;
  final void Function()? onSave;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Row(children: [
      Text(title ?? '', style: BS.reg16.apply(color: BC.white)),
      Space.w22,
      ElevatedButton(
          style: themeData.extension<AppButtonTheme>()!.successElevated,
          onPressed: () => onSave?.call(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: kDefaultPadding * 0.5),
                child: Icon(
                  Icons.add,
                  size: (themeData.textTheme.labelLarge!.fontSize! + 4.0),
                ),
              ),
              const Text('Create new'),
            ],
          )),
    ]);
  }
}
