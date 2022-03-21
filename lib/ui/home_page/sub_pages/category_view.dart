import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nsbm_navi_clear/theme/styled_colors.dart';
import 'package:nsbm_navi_clear/ui/widgets/basic_widget.dart';

class CategoryView extends StatefulWidget {
  String name = "";
  CategoryView(String nm, {Key? key}) : super(key: key) {
    name = nm;
  }

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  bool isSubCategoryView = false;

  String name = "";

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

  List<dynamic> items = [];

  @override
  Widget build(BuildContext context) {
    print("build...");
    print(widget.name);
    final Stream<QuerySnapshot> _locationsStream = widget.name == ""
        ? FirebaseFirestore.instance.collection('locations').snapshots()
        : FirebaseFirestore.instance
            .collection('locations')
            .where('name', isGreaterThanOrEqualTo: widget.name)
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
                              ? SubCategory(i, name, [])
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
                                          SubCategory(s, name, [])
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
