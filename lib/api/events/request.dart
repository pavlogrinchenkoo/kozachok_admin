import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kozachok_admin/api/events/dto.dart';

class EventRequest {
  CollectionReference events = FirebaseFirestore.instance.collection('events');

  create(EventModel data) async {
    await events.doc(data.id).set(data.toJson());
  }

  Future<List<EventModel>> getEvents() async {
    final res = await events.get();
    final List<EventModel> shows = [];
    for (var show in res.docs) {
      final showJ = show.data() as Map<String, dynamic>;
      shows.add(EventModel.fromJson(showJ));
    }
    return shows;
  }

  Future<void> delete(String id, BuildContext context) async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Delete?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await events.doc(id).delete();
              if (context.mounted) Navigator.pop(context, 'OK');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<EventModel> update(EventModel event) async {
    await events.doc(event.id).update(event.toJson());
    return event;
  }
}
