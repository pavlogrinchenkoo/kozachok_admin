import 'package:flutter/material.dart';
import 'package:kozachok_admin/screens/shows_page/bloc.dart';
import 'package:kozachok_admin/style.dart';
import 'package:kozachok_admin/utils/custom_stream_builder.dart';
import 'package:kozachok_admin/widgets/audio_select_widget.dart';
import 'package:kozachok_admin/widgets/custom_button.dart';
import 'package:kozachok_admin/widgets/custom_text_input.dart';
import 'package:kozachok_admin/widgets/image_select_widget.dart';
import 'package:kozachok_admin/widgets/spaces.dart';

class AddShowWidget extends StatefulWidget {
  const AddShowWidget({super.key, required this.bloc});

  final ShowsBloc bloc;

  @override
  State<AddShowWidget> createState() => _AddShowWidgetState();
}

class _AddShowWidgetState extends State<AddShowWidget> {
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerDesc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomStreamBuilder(
        bloc: widget.bloc,
        builder: (context, ScreenState state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add show', style: BS.bold36.apply(color: BC.white)),
              Space.h16,
              CustomTextInput(label: 'Title', controller: _controllerTitle),
              CustomTextInput(
                  label: 'Description', controller: _controllerDesc),
              Space.h16,
              Text('Add image', style: BS.med20.apply(color: BC.white)),
              Space.h16,
              ImageSelectWidget(() => widget.bloc.selectPhoto(), state.photo),
              Space.h16,
              Text('Add audio', style: BS.med20.apply(color: BC.white)),
              Space.h16,
              AudioSelectWidget(() => widget.bloc.selectAudio(), state.audio),
              Space.h16,
              CustomButton(
                text: 'Add',
                loading: state.loading,
                onTap: () async => {
                  await widget.bloc.saveShow(_controllerTitle, _controllerDesc),
                  widget.bloc.init(),
                },
              )
            ],
          );
        });
  }
}
