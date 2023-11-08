import 'package:flutter/material.dart';
import 'package:kozachok_admin/style.dart';
import 'package:kozachok_admin/widgets/custom_circular_progress_indicator.dart';
import 'package:kozachok_admin/widgets/spaces.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {this.text = '',
      this.isGray = false,
      this.customColor,
      this.withDropdownBoxShadow = false,
      this.onTap,
      this.icon,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.padding = const EdgeInsets.all(20),
      this.loading = false,
      this.expanded = true,
      this.transparent = false,
      super.key});

  final String text;
  final bool isGray;
  final Color? customColor;
  final bool withDropdownBoxShadow;
  final void Function()? onTap;
  final Widget? icon;
  final MainAxisAlignment mainAxisAlignment;
  final EdgeInsets padding;
  final bool loading;
  final bool expanded;
  final bool transparent;

  @override
  Widget build(BuildContext context) {
    final color = isGray || transparent ? BC.gray : BC.white;
    return ClipRRect(
      borderRadius: BRadius.r16,
      child: Material(
        color: transparent
            ? Colors.transparent
            : customColor ?? (isGray ? BC.silver : BC.primary),
        child: InkWell(
          splashColor: color.withOpacity(transparent ? 0 : 0.3),
          highlightColor: color.withOpacity(transparent ? 0 : 0.3),
          onTap: customColor != null ? null : (loading ? () => {} : onTap),
          child: Container(
            padding: transparent ? const EdgeInsets.all(8) : padding,
            decoration: BoxDecoration(
                boxShadow: withDropdownBoxShadow ? BShadow.def : null),
            child: loading
                ? CustomCircularProgressIndicator(color: color)
                : Row(
                    mainAxisSize:
                        expanded ? MainAxisSize.max : MainAxisSize.min,
                    mainAxisAlignment: mainAxisAlignment,
                    children: [
                      icon ?? const SizedBox.shrink(),
                      if (icon != null) Space.w16,
                      Text(text,
                          style: BS.med16.apply(
                              color:
                                  isGray || transparent ? BC.black : BC.white))
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
