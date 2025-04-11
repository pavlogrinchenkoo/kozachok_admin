import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kozachok_admin/screens/bugs_page/page.dart';
import 'package:kozachok_admin/screens/events_page/page.dart';
import 'package:kozachok_admin/screens/main/page.dart';
import 'package:kozachok_admin/screens/offered_guests_page/page.dart';
import 'package:kozachok_admin/screens/shows_page/page.dart';
import 'package:kozachok_admin/screens/splash_screen/page.dart';
import 'package:kozachok_admin/widgets/chage_page.dart';

part 'routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(path: '/', page: SplashRoute.page),
    AutoRoute(path: '/main', page: MainRoute.page, children: [
      AutoRoute(path: 'shows', page: ShowsRoute.page),
      AutoRoute(path: 'events', page: EventsRoute.page),
      AutoRoute(path: 'guests', page: OfferedGuestsRoute.page),
      AutoRoute(path: 'bugs', page: BugsRoute.page),
    ]),
    AutoRoute(path: '/change', page: ChangeRoute.page),
  ];
}

// dart run build_runner watch
// dart run build_runner build
