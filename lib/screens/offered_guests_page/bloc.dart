import 'package:flutter/material.dart';
import 'package:kozachok_admin/api/offer_guest/dto.dart';
import 'package:kozachok_admin/api/offer_guest/request.dart';
import 'package:kozachok_admin/utils/bloc_base.dart';

class OfferedGuestsBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final OfferGuestRequest _request = OfferGuestRequest();

  OfferedGuestsBloc() {
    setState(ScreenState());
  }

  Future<void> init() async {
    final List<OfferGuestModel> offers = await _request.getGuests();
    offers.sort((a, b) => b.date!.compareTo(a.date!));
    setState(currentState.copyWith(offers: offers));
  }

  delete(id, BuildContext context) async {
    await _request.delete(id, context);
    init();
  }
}

class ScreenState {
  final bool loading;
  final List<OfferGuestModel> offers;

  ScreenState({this.loading = false, this.offers = const []});

  ScreenState copyWith({bool? loading, List<OfferGuestModel>? offers}) {
    return ScreenState(
        loading: loading ?? this.loading, offers: offers ?? this.offers);
  }
}
