import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../db/location_api.dart';
import '../../../theme/styled_colors.dart';
import '../../widgets/basic_widget.dart';

class FavouriteView extends StatefulWidget {
  const FavouriteView({Key? key}) : super(key: key);

  @override
  State<FavouriteView> createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView> {
  bool isSubCategoryView = false;
  String name = "";
  List<dynamic> items = [];
  List<dynamic> favItems = [];

  Container getCategory(BuildContext context, String img, String text) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 180.0,
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            blurRadius: 5,
            color: Colors.black.withOpacity(0.3),
          ),
        ],
      ),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 120.0,
                fit: BoxFit.fill,
                image: NetworkImage(img)),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SizedBox(
                  height: 30,
                  child: Text(
                    text,
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _locationsStream = FirebaseFirestore.instance
        .collection('locations')
        .where('isFav', isEqualTo: true)
        .snapshots();

    SizedBox getSubLocationView() {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Scrollbar(
          thickness: 0,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isSubCategoryView = false;
                      });
                    },
                    child: const Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Icon(Icons.arrow_back_ios),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Column(
                children: [
                  for (var i in items)
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      margin: const EdgeInsets.symmetric(vertical: 7.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            i["name"],
                            style: const TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                          i["superSubitems"] == null
                              ? SubCategory(i, name,favItems)
                              : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              for (var s in i["superSubitems"])
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      s["title"],
                                      style: const TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w400),
                                      textAlign: TextAlign.start,
                                    ),
                                    SubCategory(s, name,favItems)
                                  ],
                                ),
                            ],
                          )
                        ],
                      ),
                    )
                ],
              )
            ],
          ),
        ),
      );
    }

    return isSubCategoryView
        ? getSubLocationView()
        : StreamBuilder<QuerySnapshot>(
            stream: _locationsStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: StyledColor.blurPrimary,
                  ),
                );
              }
              if (snapshot.hasError) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Something went wrong...'),
                  backgroundColor: Colors.redAccent,
                ));
              }
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        items = data["items"];
                        name = data["name"];
                        favItems = data["favList"];
                        isSubCategoryView = true;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: getCategory(
                        context,
                        "${data["image"]}",
                        "${data["name"]}",
                      ),
                    ),
                  );
                }).toList(),
              );
            });
  }
}
