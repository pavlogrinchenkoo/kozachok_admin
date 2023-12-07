import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kozachok_admin/api/events/dto.dart';
import 'package:kozachok_admin/screens/events_page/bloc.dart';
import 'package:kozachok_admin/style.dart';
import 'package:kozachok_admin/utils/custom_stream_builder.dart';
import 'package:kozachok_admin/widgets/custom_checkbox.dart';
import 'package:kozachok_admin/widgets/custom_open_icon.dart';
import 'package:kozachok_admin/widgets/custom_sheet_header_widget.dart';
import 'package:kozachok_admin/widgets/custom_sheet_widget.dart';
import 'package:kozachok_admin/widgets/sheets_text.dart';
import 'package:kozachok_admin/widgets/spaces.dart';

@RoutePage()
class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final EventsBloc _bloc = EventsBloc();
  final titles = [
    'Id',
    'Name',
    'Place',
    'Paid',
    'Status',
  ];

  @override
  void initState() {
    _bloc.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomStreamBuilder(
        bloc: _bloc,
        builder: (context, ScreenState state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSheetHeaderWidget(
                      title: 'Events',
                      onSave: () =>
                          _bloc.openChange(context, EventModel(), -1)),
                  Space.h32,
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomSheetWidget(
                            columns: <DataColumn>[
                              for (final title in titles)
                                DataColumn(
                                  label: Expanded(
                                    child: Text(title),
                                  ),
                                ),
                            ],
                            rows: _rows(state.events),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _rows(List<EventModel?> events) {
    final List<DataRow> rows = [];
    for (int i = 0; i < events.length; i++) {
      final EventModel? item = events[i];
      rows.add(DataRow(
        cells: <DataCell>[
          DataCell(InkWell(
              borderRadius: BRadius.r6,
              onTap: () => _bloc.openChange(context, item, i),
              child: Row(
                children: [
                  Expanded(child: SheetText(text: i)),
                  Space.w16,
                  const CustomOpenIcon()
                ],
              ))),
          DataCell(SheetText(text: item?.name)),
          DataCell(SheetText(text: item?.eventPlace)),
          DataCell(CustomCheckbox(value: item?.isPaid)),
          DataCell(SheetText(text: item?.status.toString().split('.').last)),
        ],
      ));
    }
    return rows;
  }
}
