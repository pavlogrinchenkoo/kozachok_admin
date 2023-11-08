import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:kozachok_admin/screens/offered_guests_page/bloc.dart';
import 'package:kozachok_admin/screens/offered_guests_page/guests_widget.dart';
import 'package:kozachok_admin/utils/custom_stream_builder.dart';
import 'package:kozachok_admin/widgets/spaces.dart';

@RoutePage()
class OfferedGuestsPage extends StatefulWidget {
  const OfferedGuestsPage({super.key});

  @override
  State<OfferedGuestsPage> createState() => _OfferedGuestsPageState();
}

class _OfferedGuestsPageState extends State<OfferedGuestsPage> {
  final OfferedGuestsBloc _bloc = OfferedGuestsBloc();

  @override
  void initState() {
    _bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomStreamBuilder(
        bloc: _bloc,
        builder: (context, ScreenState state) {
          return ListView(children: [
            Space.h16,
            for (final offer in state.offers)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Center(
                    child:
                    SizedBox(width: 400, child: GuestsWidget(offer, _bloc))),
              )
          ]);
        });
  }
}
