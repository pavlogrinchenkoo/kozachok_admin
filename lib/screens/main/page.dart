import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kozachok_admin/routers/routes.dart';
import 'package:kozachok_admin/screens/bugs_page/page.dart';
import 'package:kozachok_admin/screens/events_page/page.dart';
import 'package:kozachok_admin/screens/offered_guests_page/page.dart';
import 'package:kozachok_admin/screens/shows_page/page.dart';
import 'package:kozachok_admin/style.dart';
import 'package:kozachok_admin/utils/custom_stream_builder.dart';
import 'package:kozachok_admin/widgets/custom_auto_tabs_scaffold.dart';
import 'package:kozachok_admin/widgets/custom_side_bar.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    controller = TabController(length: 4, vsync: this);
    super.initState();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return DefaultTabController(
  //     length: 4,
  //     child: Scaffold(
  //         body: Column(children: [
  //           Container(
  //             decoration: BoxDecoration(color: BC.primary),
  //             child: TabBar(
  //               indicatorColor: BC.white,
  //               controller: controller,
  //               tabs: [
  //                 Tab(
  //                     icon:
  //                         Text('Shows', style: BS.med20.apply(color: BC.white))),
  //                 Tab(
  //                     icon:
  //                         Text('Events', style: BS.med20.apply(color: BC.white))),
  //                 Tab(
  //                     icon: Text('Offered guests',
  //                         style: BS.med20.apply(color: BC.white))),
  //                 Tab(icon: Text('Bugs', style: BS.med20.apply(color: BC.white))),
  //               ],
  //             ),
  //           ),
  //           Expanded(
  //             child: TabBarView(
  //               controller: controller,
  //               children: const [
  //                 ShowsPage(),
  //                 EventsPage(),
  //                 OfferedGuestsPage(),
  //                 BugsPage()
  //               ],
  //             ),
  //           ),
  //         ])),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return CustomAutoTabsScaffold(
      routes: const [
        ShowsRoute(),
        EventsRoute(),
        OfferedGuestsRoute(),
        BugsRoute(),
      ],
      bodyBuilder: (_, tabsRouter) {
        return CustomSideBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
        );
      },
    );
  }
}
