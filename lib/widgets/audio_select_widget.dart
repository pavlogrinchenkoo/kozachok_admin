import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kozachok_admin/style.dart';

class AudioSelectWidget extends StatelessWidget {
  const AudioSelectWidget(this.onTap, this.file, {super.key});

  final void Function() onTap;
  final XFile? file;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BRadius.r16,
      onTap: onTap,
      child: Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BRadius.r16,
              border: Border.all(width: 1, color: BC.primary)),
          child: file == null
              ? const Icon(CupertinoIcons.add)
              : Center(child: Text(file?.name ?? '', style: BS.med20))),
    );
  }
}
