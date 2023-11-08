import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:kozachok_admin/screens/shows_page/add_show/widget.dart';
import 'package:kozachok_admin/screens/shows_page/bloc.dart';
import 'package:kozachok_admin/screens/shows_page/list_shows/widget.dart';
import 'package:kozachok_admin/widgets/spaces.dart';

@RoutePage()
class ShowsPage extends StatefulWidget {
  const ShowsPage({super.key});

  @override
  State<ShowsPage> createState() => _ShowsPageState();
}

class _ShowsPageState extends State<ShowsPage> {
  final ShowsBloc _bloc = ShowsBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(child: AddShowWidget(bloc: _bloc)),
          Space.w20,
          SizedBox(width: 400, child: ListShowWidget(bloc: _bloc)),
        ],
      ),
    );
  }
}
