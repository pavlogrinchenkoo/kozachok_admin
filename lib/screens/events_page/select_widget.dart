import 'package:flutter/material.dart';
import 'package:kozachok_admin/api/events/dto.dart';

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({this.status, required this.onChange, super.key});

  final void Function(EventStatus status) onChange;
  final EventStatus? status;

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  @override
  Widget build(BuildContext context) {
    const list = EventStatus.values;
    EventStatus dropdownValue = widget.status ?? list.first;

    return DropdownMenu<EventStatus>(
      initialSelection: dropdownValue,
      onSelected: (EventStatus? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
        widget.onChange(dropdownValue);
      },
      dropdownMenuEntries:
          list.map<DropdownMenuEntry<EventStatus>>((EventStatus value) {
        return DropdownMenuEntry<EventStatus>(
            value: value, label: value.toString());
      }).toList(),
    );
  }
}
