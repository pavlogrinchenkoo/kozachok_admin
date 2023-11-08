import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kozachok_admin/screens/shows_page/bloc.dart';
import 'package:kozachok_admin/utils/custom_stream_builder.dart';

import 'show_widget.dart';

class ListShowWidget extends StatefulWidget {
  const ListShowWidget({super.key, required this.bloc});

  final ShowsBloc bloc;

  @override
  State<ListShowWidget> createState() => _ListShowWidgetState();
}

class _ListShowWidgetState extends State<ListShowWidget> {
  Uint8List? fileU;

  @override
  void initState() {
    widget.bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomStreamBuilder(
        bloc: widget.bloc,
        builder: (context, ScreenState state) {
          return ListView(children: [
            for (final show in state.shows) ShowWidget(show, widget.bloc)
          ]);
        });
  }
}
