import 'package:flutter/material.dart';
import 'package:kozachok_admin/api/bugs/dto.dart';
import 'package:kozachok_admin/api/bugs/request.dart';
import 'package:kozachok_admin/utils/bloc_base.dart';

class BugsBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final BugsRequest _request = BugsRequest();

  BugsBloc() {
    setState(ScreenState());
  }

  Future<void> init() async {
    final List<BugModel> bugs = await _request.getBugs();
    bugs.sort((a, b) => b.date!.compareTo(a.date!));
    setState(currentState.copyWith(bugs: bugs));
  }

  delete(id, BuildContext context) async {
    await _request.delete(id, context);
    init();
  }
}

class ScreenState {
  final bool loading;
  List<BugModel> bugs;

  ScreenState({this.loading = false, this.bugs = const []});

  ScreenState copyWith({bool? loading, List<BugModel>? bugs}) {
    return ScreenState(
        loading: loading ?? this.loading, bugs: bugs ?? this.bugs);
  }
}
