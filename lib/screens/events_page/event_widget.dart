import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kozachok_admin/api/events/dto.dart';
import 'package:kozachok_admin/api/storage/request.dart';
import 'package:kozachok_admin/screens/events_page/bloc.dart';
import 'package:kozachok_admin/screens/events_page/select_widget.dart';
import 'package:kozachok_admin/style.dart';
import 'package:kozachok_admin/utils/custom_function.dart';
import 'package:kozachok_admin/widgets/spaces.dart';

class EventWidget extends StatefulWidget {
  const EventWidget(this.event, this.bloc, {super.key});

  final EventModel event;
  final EventsBloc bloc;

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  final StorageRequest _storage = StorageRequest();
  Uint8List? image;

  @override
  void initState() {
    initMedia();
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
              ShowCoverWidget(image),
              Space.h16,
              Text(
                widget.event.name ?? '',
                style: BS.med20,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Space.h8,
              Text(
                getDateString(widget.event.theDateOfThe),
                style: BS.reg12..apply(color: SC.s30),
              ),
              Space.h16,
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: double.infinity,
                  height: 1,
                  color: SC.s60),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  widget.event.desc ?? '',
                  style: BS.reg16.apply(color: BC.black),
                  textAlign: TextAlign.center,
                ),
              ),
              DropdownMenuExample(
                  status: widget.event.status,
                  onChange: (EventStatus status) =>
                      widget.bloc.updateStatus(status, widget.event, context)),
              IconButton(
                  onPressed: () =>
                      widget.bloc.delete(widget.event.id ?? '', context),
                  icon: const Icon(Icons.delete)),
              Space.h16,
            ],
          )),
    );
  }

  Future<void> initMedia() async {
    final image = await _storage.getImage(widget.event.image ?? '');

    setState(() {
      this.image = image;
    });
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
