// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'routes.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    BugsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BugsPage(),
      );
    },
    ChangeRoute.name: (routeData) {
      final args = routeData.argsAs<ChangeRouteArgs>(
          orElse: () => const ChangeRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ChangePage(
          fields: args.fields,
          title: args.title,
          onSave: args.onSave,
          widget: args.widget,
          key: args.key,
        ),
      );
    },
    EventsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EventsPage(),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainScreen(),
      );
    },
    OfferedGuestsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OfferedGuestsPage(),
      );
    },
    ShowsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ShowsPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashScreen(),
      );
    },
  };
}

/// generated route for
/// [BugsPage]
class BugsRoute extends PageRouteInfo<void> {
  const BugsRoute({List<PageRouteInfo>? children})
      : super(
          BugsRoute.name,
          initialChildren: children,
        );

  static const String name = 'BugsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ChangePage]
class ChangeRoute extends PageRouteInfo<ChangeRouteArgs> {
  ChangeRoute({
    List<FieldModel>? fields,
    String? title,
    void Function()? onSave,
    Widget? widget,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ChangeRoute.name,
          args: ChangeRouteArgs(
            fields: fields,
            title: title,
            onSave: onSave,
            widget: widget,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ChangeRoute';

  static const PageInfo<ChangeRouteArgs> page = PageInfo<ChangeRouteArgs>(name);
}

class ChangeRouteArgs {
  const ChangeRouteArgs({
    this.fields,
    this.title,
    this.onSave,
    this.widget,
    this.key,
  });

  final List<FieldModel>? fields;

  final String? title;

  final void Function()? onSave;

  final Widget? widget;

  final Key? key;

  @override
  String toString() {
    return 'ChangeRouteArgs{fields: $fields, title: $title, onSave: $onSave, widget: $widget, key: $key}';
  }
}

/// generated route for
/// [EventsPage]
class EventsRoute extends PageRouteInfo<void> {
  const EventsRoute({List<PageRouteInfo>? children})
      : super(
          EventsRoute.name,
          initialChildren: children,
        );

  static const String name = 'EventsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OfferedGuestsPage]
class OfferedGuestsRoute extends PageRouteInfo<void> {
  const OfferedGuestsRoute({List<PageRouteInfo>? children})
      : super(
          OfferedGuestsRoute.name,
          initialChildren: children,
        );

  static const String name = 'OfferedGuestsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ShowsPage]
class ShowsRoute extends PageRouteInfo<void> {
  const ShowsRoute({List<PageRouteInfo>? children})
      : super(
          ShowsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShowsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
