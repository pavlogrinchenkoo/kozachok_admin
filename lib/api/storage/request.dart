import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageRequest {
  final storageRef = FirebaseStorage.instance.ref();

  Future<Uint8List?> getImage(String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final imageRef = storageRef.child('image/$name');

    Uint8List? image;
    final locFile = prefs.getString(name);

    if (locFile != null) {
      image = base64Decode(locFile);
    } else {
      image = await imageRef.getData();
      if (image != null) {
        List<int> imageBytes = image.toList();
        String base64Image = base64Encode(imageBytes);
        prefs.setString(name, base64Image);
      }
    }

    return image;
  }

  Future<Uint8List?> changeImage(String name, XFile? file) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final imageRef = storageRef.child('image/$name');

    final b = await file?.readAsBytes();

    await imageRef.putData(b!);

    final image = await getImage(name);
    return image;
  }

  Future<void> deleteImage(String name) async {
    final imageRef = storageRef.child('image/$name');

    await imageRef.delete();
  }

  Future<Uint8List?> getAudio(String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final audioRef = storageRef.child('audio/$name');

    Uint8List? audio;
    final locFile = prefs.getString(name);

    if (locFile != null) {
      audio = base64Decode(locFile);
    } else {
      audio = await audioRef.getData();
      if (audio != null) {
        List<int> imageBytes = audio.toList();
        String base64Image = base64Encode(imageBytes);
        prefs.setString(name, base64Image);
      }
    }

    return audio;
  }

  Future<void> deleteAudio(String name) async {
    final imageRef = storageRef.child('audio/$name');

    await imageRef.delete();
  }
}
