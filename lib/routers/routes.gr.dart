// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'routes.dart';

/// generated route for
/// [BugsPage]
class BugsRoute extends PageRouteInfo<void> {
  const BugsRoute({List<PageRouteInfo>? children})
    : super(BugsRoute.name, initialChildren: children);

  static const String name = 'BugsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const BugsPage();
    },
  );
}

/// generated route for
/// [ChangePage]
class ChangeRoute extends PageRouteInfo<ChangeRouteArgs> {
  ChangeRoute({
    List<FieldModel>? fields,
    String? title,
    void Function()? onSave,
    void Function()? onDelete,
    Widget? widget,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         ChangeRoute.name,
         args: ChangeRouteArgs(
           fields: fields,
           title: title,
           onSave: onSave,
           onDelete: onDelete,
           widget: widget,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'ChangeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChangeRouteArgs>(
        orElse: () => const ChangeRouteArgs(),
      );
      return ChangePage(
        fields: args.fields,
        title: args.title,
        onSave: args.onSave,
        onDelete: args.onDelete,
        widget: args.widget,
        key: args.key,
      );
    },
  );
}

class ChangeRouteArgs {
  const ChangeRouteArgs({
    this.fields,
    this.title,
    this.onSave,
    this.onDelete,
    this.widget,
    this.key,
  });

  final List<FieldModel>? fields;

  final String? title;

  final void Function()? onSave;

  final void Function()? onDelete;

  final Widget? widget;

  final Key? key;

  @override
  String toString() {
    return 'ChangeRouteArgs{fields: $fields, title: $title, onSave: $onSave, onDelete: $onDelete, widget: $widget, key: $key}';
  }
}

/// generated route for
/// [EventsPage]
class EventsRoute extends PageRouteInfo<void> {
  const EventsRoute({List<PageRouteInfo>? children})
    : super(EventsRoute.name, initialChildren: children);

  static const String name = 'EventsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const EventsPage();
    },
  );
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainScreen();
    },
  );
}

/// generated route for
/// [OfferedGuestsPage]
class OfferedGuestsRoute extends PageRouteInfo<void> {
  const OfferedGuestsRoute({List<PageRouteInfo>? children})
    : super(OfferedGuestsRoute.name, initialChildren: children);

  static const String name = 'OfferedGuestsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OfferedGuestsPage();
    },
  );
}

/// generated route for
/// [ShowsPage]
class ShowsRoute extends PageRouteInfo<void> {
  const ShowsRoute({List<PageRouteInfo>? children})
    : super(ShowsRoute.name, initialChildren: children);

  static const String name = 'ShowsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ShowsPage();
    },
  );
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashScreen();
    },
  );
}
