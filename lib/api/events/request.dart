import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kozachok_admin/api/events/dto.dart';

import '../storage/request.dart';

class EventRequest {
  CollectionReference events = FirebaseFirestore.instance.collection('events');
  final StorageRequest _storage = StorageRequest();

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

  deleteEvent(String id) async {
    final event = (await events.doc(id).get()).data() as Map<String, dynamic>;
    await events.doc(id).delete();
    _storage.deleteImage(event['image']);
  }

  Future<void> delete(String id, BuildContext context,
      {bool withOutDialog = false}) async {
    if (withOutDialog) {
      deleteEvent(id);
      return;
    }
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
              await deleteEvent(id);
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
