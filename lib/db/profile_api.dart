import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsbm_navi_clear/db/model/profile.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

class ProfileApi {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<Profile> getUser(String? email) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final u = await users.where('email', isEqualTo: email).limit(1).get();
    final doc = u.docs.first;
    final Profile profile = Profile(
        email: doc['email'],
        displayName: doc['displayName'],
        profilePicture: doc['profilePicture']);
    return profile;
  }

  Future uploadImage(File image, BuildContext context) async {
    final fileName = basename(image.path);
    final destination = 'profile/$fileName';
    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(image);
      await updateProfile(url: await ref.getDownloadURL());
    } catch (e) {
      print('error occured');
    }
  }

  Future updateProfile({String? name, String? url}) async {
    final user = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final u = await users.where('email', isEqualTo: user?.email).limit(1).get();
    final doc = u.docs.first;
    if (url != null) {
      await users.doc(doc.id).update({'profilePicture': url});
    } else {
      await users.doc(doc.id).update({'displayName': name});
    }
  }
}
