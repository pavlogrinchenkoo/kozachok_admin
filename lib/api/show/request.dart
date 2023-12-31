import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kozachok_admin/api/show/dto.dart';
import 'package:kozachok_admin/api/storage/request.dart';

class ShowsRequest {
  CollectionReference shows = FirebaseFirestore.instance.collection('shows');
  final StorageRequest _storage = StorageRequest();

  setShows(ShowModel data) async {
    await shows.doc(data.id).set(data.toJson());
  }

  Future<List<ShowModel>> getShows() async {
    final res = await this.shows.get();
    final List<ShowModel> shows = [];
    for (var show in res.docs) {
      final showJ = show.data() as Map<String, dynamic>;
      shows.add(ShowModel.fromJson(showJ));
    }
    return shows;
  }

  deleteShow(String id) async {
    final show = (await shows.doc(id).get()).data() as Map<String, dynamic>;
    await shows.doc(id).delete();
    _storage.deleteImage(show['photo']);
    _storage.deleteAudio(show['audio']);
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
              deleteShow(id);
              if (context.mounted) Navigator.pop(context, 'OK');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<ShowModel> update(ShowModel event) async {
    await shows.doc(event.id).update(event.toJson());
    return event;
  }

  Future<ShowModel> create(ShowModel event) async {
    await shows.doc(event.id).set(event.toJson());
    return event;
  }
}
