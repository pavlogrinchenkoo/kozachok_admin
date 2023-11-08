import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:kozachok_admin/screens/bugs_page/bloc.dart';
import 'package:kozachok_admin/screens/bugs_page/bug_widget.dart';
import 'package:kozachok_admin/utils/custom_stream_builder.dart';
import 'package:kozachok_admin/widgets/spaces.dart';

@RoutePage()
class BugsPage extends StatefulWidget {
  const BugsPage({super.key});

  @override
  State<BugsPage> createState() => _BugsPageState();
}

class _BugsPageState extends State<BugsPage> {
  final BugsBloc _bloc = BugsBloc();

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
            for (final bug in state.bugs)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Center(
                    child:
                        SizedBox(width: 400, child: BugWidget(bug, _bloc))),
              )
          ]);
        });
  }
}
