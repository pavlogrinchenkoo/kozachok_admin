import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kozachok_admin/api/offer_guest/dto.dart';

class OfferGuestRequest {
  CollectionReference guests = FirebaseFirestore.instance.collection('guests');

  setOfferGuest(OfferGuestModel data) async {
    await guests.doc(data.id).set(data.toJson());
  }

  Future<List<OfferGuestModel>> getGuests() async {
    final res = await guests.get();
    final List<OfferGuestModel> shows = [];
    for (var show in res.docs) {
      final showJ = show.data() as Map<String, dynamic>;
      shows.add(OfferGuestModel.fromJson(showJ));
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
              await guests.doc(id).delete();
              if (context.mounted) Navigator.pop(context, 'OK');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
