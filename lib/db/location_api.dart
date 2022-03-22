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

  Future getNavigation(String fromWhere,String toWhere)async{
    final QuerySnapshot _navigationStream = await FirebaseFirestore.instance
        .collection('navigations')
        .where('fromWhere', isEqualTo: fromWhere)
        .where('toWhere', isEqualTo: toWhere).get();
    if(_navigationStream.docs.isNotEmpty){
      final doc = _navigationStream.docs.first;
      return doc;
    }
  }
}
