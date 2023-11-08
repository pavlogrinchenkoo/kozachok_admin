import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kozachok_admin/api/bugs/dto.dart';

class BugsRequest {
  CollectionReference bugs = FirebaseFirestore.instance.collection('bugs');

  setOfferGuest(BugModel data) async {
    await bugs.doc(data.id).set(data.toJson());
  }

  Future<List<BugModel>> getBugs() async {
    final res = await this.bugs.get();
    final List<BugModel> bugs = [];
    for (var show in res.docs) {
      final showJ = show.data() as Map<String, dynamic>;
      bugs.add(BugModel.fromJson(showJ));
    }
    return bugs;
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
              await bugs.doc(id).delete();
              if (context.mounted) Navigator.pop(context, 'OK');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
