import 'package:flutter/material.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
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
      child: InkWell(
        onTap: () {},
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
                      style:
                          const TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          getCategory(
              context,
              "https://firebasestorage.googleapis.com/v0/b/navi-clear.appspot.com/o/1212.jpeg?alt=media&token=84c25d6d-8238-4a93-b888-0703f4bbd6f8",
              "NSBM - SOC"),
          getCategory(
              context,
              "https://firebasestorage.googleapis.com/v0/b/navi-clear.appspot.com/o/intro-image.jpeg?alt=media&token=fe313b7f-40c1-493c-98e7-2878f154c6d4",
              "One Galle Face"),
          getCategory(
              context,
              "https://firebasestorage.googleapis.com/v0/b/navi-clear.appspot.com/o/DSC03113-e1492752901317.jpeg?alt=media&token=bc2f42d9-4a79-4db9-ad65-d3bc9ef4abd8",
              "Colombo South Teaching Hospital"),
        ],
      ),
    );
  }
}
