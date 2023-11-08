import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kozachok_admin/api/show/dto.dart';

class ShowsRequest {
  CollectionReference shows = FirebaseFirestore.instance.collection('shows');

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
              await shows.doc(id).delete();
              if (context.mounted) Navigator.pop(context, 'OK');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
