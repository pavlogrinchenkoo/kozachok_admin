import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kozachok_admin/api/show/dto.dart';
import 'package:kozachok_admin/api/storage/request.dart';
import 'package:kozachok_admin/screens/shows_page/bloc.dart';
import 'package:kozachok_admin/style.dart';
import 'package:kozachok_admin/utils/custom_function.dart';
import 'package:kozachok_admin/widgets/spaces.dart';

class ShowWidget extends StatefulWidget {
  const ShowWidget(this.show, this.bloc, {super.key});

  final ShowModel show;
  final ShowsBloc bloc;

  @override
  State<ShowWidget> createState() => _ShowWidgetState();
}

class _ShowWidgetState extends State<ShowWidget> {
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
          decoration: BoxDecoration(color: BC.white),
          child: Column(
            children: [
              ShowCoverWidget(image),
              Space.h16,
              Text(
                widget.show.title ?? '',
                style: BS.med20,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Space.h8,
              Text(
                getDateString(widget.show.date),
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
                  widget.show.description ?? '',
                  style: BS.reg16.apply(color: BC.black),
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                  onPressed: () => widget.bloc.delete(widget.show.id, context),
                  icon: const Icon(Icons.delete)),
              Space.h16,
            ],
          )),
    );
  }

  Future<void> initMedia() async {
    final image = await _storage.getImage(widget.show.photo ?? '');

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
            height: 200,
            width: double.infinity,
            child:
                image != null ? Image.memory(image!, fit: BoxFit.cover) : null),
      ],
    );
  }
}
