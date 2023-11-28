import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kozachok_admin/api/events/dto.dart';
import 'package:kozachok_admin/api/events/request.dart';
import 'package:kozachok_admin/routers/routes.dart';
import 'package:kozachok_admin/utils/bloc_base.dart';
import 'package:kozachok_admin/widgets/chage_page.dart';

class EventsBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final EventRequest _request = EventRequest();

  EventsBloc() {
    setState(ScreenState());
  }

  Future<void> init() async {
    final List<EventModel> events = await _request.getEvents();
    events.sort((a, b) => b.date!.compareTo(a.date!));
    setState(currentState.copyWith(events: events));
  }

  delete(String id, BuildContext context) async {
    await _request.delete(id, context);
    init();
  }

  updateStatus(EventStatus status, EventModel event) async {
    event.status = status;
    await _request.update(event);
    init();
  }

  openChange(BuildContext context, EventModel? item, int i) {
    final fields = [
      FieldModel(
        title: 'Name',
        type: FieldType.text,
        required: true,
        controller: TextEditingController(text: item?.name),
      ),
      FieldModel(
        title: 'Place',
        type: FieldType.text,
        required: true,
        controller: TextEditingController(text: item?.eventPlace),
      ),
      FieldModel(
        title: 'Is paid',
        type: FieldType.checkbox,
        value: item?.isPaid ?? false,
        controller: TextEditingController(text: item?.date?.toIso8601String()),
      ),
      // FieldModel(
      //   title: 'Image',
      //   type: FieldType.avatar,
      //   image: item?.image,
      // ),
      FieldModel(
        title: 'Description',
        type: FieldType.text,
        controller: TextEditingController(text: item?.name),
      ),
      FieldModel(
        title: 'The date of the',
        type: FieldType.dateTime,
        required: true,
        controller: TextEditingController(text: item?.date?.toIso8601String()),
      ),
      FieldModel(
        title: 'Contact',
        type: FieldType.text,
        controller: TextEditingController(text: item?.name),
      ),
      FieldModel(
        title: 'Status',
        type: FieldType.dropdown,
        enumValue: item?.status,
        values: EventStatus.values,
        required: true,
      ),
    ];

    context.router.push(ChangeRoute(
        fields: fields,
        title: 'Event',
        onSave: () =>
            {onSave(context, fields, item, i, isCreate: item?.id == null)}));
  }

  onSave(BuildContext context, List<FieldModel> fields, EventModel? item, int i,
      {bool isCreate = false}) async {
    final newModel = EventModel(
        name: fields.firstWhere((i) => i.title == 'Name').controller?.text,
        eventPlace:
            fields.firstWhere((i) => i.title == 'Place').controller?.text,
        isPaid: fields.firstWhere((i) => i.title == 'Is paid').value ?? false,
        // image: fields.firstWhere((i) => i.title == 'Image').imageId,
        desc:
            fields.firstWhere((i) => i.title == 'Description').controller?.text,
        theDateOfThe: DateTime.tryParse(
            fields.firstWhere((i) => i.title == 'The date of the').controller?.text ??
                DateTime.now().toIso8601String()),
        contact:
            fields.firstWhere((i) => i.title == 'Contact').controller?.text,
        status: fields.firstWhere((i) => i.title == 'Status').enumValue,
        id: item?.id,
        date: item?.date ?? DateTime.now());

    if (isCreate) {
      onCreate(context, newModel, i);
      return;
    }
    final res = await _request.update(newModel);
    replaceItem(res, newModel, i);
    if (context.mounted) context.router.pop();
  }

  void replaceItem(EventModel changed, EventModel newVariable, int i) {
    if (changed.id == null) return;
    final events = [...currentState.events];
    if (i == -1) {
      newVariable
        ..id = changed.id
        ..date = changed.date;
      events.add(newVariable);
    } else {
      events.replaceRange(i, i + 1, [changed]);
    }
    setState(currentState.copyWith(events: events));
  }

  Future<void> onCreate(
      BuildContext context, EventModel newModel, int i) async {
    final requestModel = EventModel(
        name: newModel.name,
        eventPlace: newModel.eventPlace,
        isPaid: newModel.isPaid,
        image: newModel.image,
        desc: newModel.desc,
        theDateOfThe: newModel.theDateOfThe,
        contact: newModel.contact,
        status: newModel.status,
        date: newModel.date,
        id: newModel.id);

    final res = await _request.create(requestModel);
    replaceItem(res, newModel, i);
    if (context.mounted) context.router.pop();
  }
}

class ScreenState {
  final bool loading;
  final List<EventModel> events;

  ScreenState({this.loading = false, this.events = const []});

  ScreenState copyWith({bool? loading, List<EventModel>? events}) {
    return ScreenState(
        loading: loading ?? this.loading, events: events ?? this.events);
  }
}
