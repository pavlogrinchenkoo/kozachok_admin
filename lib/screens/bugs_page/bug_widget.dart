import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kozachok_admin/api/bugs/dto.dart';
import 'package:kozachok_admin/screens/bugs_page/bloc.dart';
import 'package:kozachok_admin/style.dart';
import 'package:kozachok_admin/utils/custom_function.dart';
import 'package:kozachok_admin/widgets/spaces.dart';

class BugWidget extends StatefulWidget {
  const BugWidget(this.bug, this.bloc, {super.key});

  final BugModel bug;
  final BugsBloc bloc;

  @override
  State<BugWidget> createState() => _BugWidgetState();
}

class _BugWidgetState extends State<BugWidget> {
  Uint8List? image;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BRadius.r16,
      child: Container(
          width: image != null ? 400 : 0,
          decoration: BoxDecoration(color: BC.white),
          child: Column(
            children: [
              Space.h16,
              Text(
                getDateString(widget.bug.date),
                style: BS.reg12..apply(color: SC.s30),
              ),
              Space.h16,
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: double.infinity,
                  height: 1,
                  color: SC.s60),
              Space.h16,
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  (widget.bug.desc ?? '').trim(),
                  style: BS.reg16.apply(color: BC.black),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  widget.bug.contact ?? '',
                  style: BS.reg16.apply(color: BC.black),
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                  onPressed: () =>
                      widget.bloc.delete(widget.bug.id ?? '', context),
                  icon: const Icon(Icons.delete)),
              Space.h16,
            ],
          )),
    );
  }
}

class ShowCoverWidget extends StatelessWidget {
  const ShowCoverWidget(this.image, {super.key});

  final Uint8List? image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: image != null ? 200 : 0,
            width: double.infinity,
            child:
                image != null ? Image.memory(image!, fit: BoxFit.cover) : null),
      ],
    );
  }
}
