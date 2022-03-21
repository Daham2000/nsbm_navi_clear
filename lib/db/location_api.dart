import 'package:cloud_firestore/cloud_firestore.dart';

class LocationApi {
  CollectionReference locations =
      FirebaseFirestore.instance.collection('locations');

  Future updateLocationFav(String name, String favItem) async {
    final loc = await locations.where('name', isEqualTo: name).limit(1).get();
    final doc = loc.docs.first;
    final List<dynamic> favList = doc["favList"];
    if (!favList.contains(favItem)) {
      favList.add(favItem);
    }
    await locations.doc(doc.id).update({'favList': favList, "isFav": true});
  }
}
