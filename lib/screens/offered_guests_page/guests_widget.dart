import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kozachok_admin/api/offer_guest/dto.dart';
import 'package:kozachok_admin/screens/events_page/select_widget.dart';
import 'package:kozachok_admin/screens/offered_guests_page/bloc.dart';
import 'package:kozachok_admin/style.dart';
import 'package:kozachok_admin/utils/custom_function.dart';
import 'package:kozachok_admin/widgets/spaces.dart';

class GuestsWidget extends StatefulWidget {
  const GuestsWidget(this.offer, this.bloc, {super.key});

  final OfferGuestModel offer;
  final OfferedGuestsBloc bloc;

  @override
  State<GuestsWidget> createState() => _GuestsWidgetState();
}

class _GuestsWidgetState extends State<GuestsWidget> {
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
                widget.offer.name ?? '',
                style: BS.med20,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Space.h8,
              Text(
                getDateString(widget.offer.date),
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
                  (widget.offer.shortStory ?? '').trim(),
                  style: BS.reg16.apply(color: BC.black),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  widget.offer.contact ?? '',
                  style: BS.reg16.apply(color: BC.black),
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                  onPressed: () =>
                      widget.bloc.delete(widget.offer.id ?? '', context),
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
