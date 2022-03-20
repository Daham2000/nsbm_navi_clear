import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nsbm_navi_clear/db/model/profile.dart';

class ProfileApi {
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

  Future uploadImage(File image)async{

  }
}
