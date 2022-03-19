import 'package:flutter/material.dart';

class FavouriteView extends StatefulWidget {
  const FavouriteView({Key? key}) : super(key: key);

  @override
  State<FavouriteView> createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView> {
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
              "http://i1.wp.com/securityaffairs.co/wordpress/"
                  "wp-content/uploads/2016/05/soc-Security-Operations-Center."
                  "png?resize=300185",
              "NSBM - SOC"),
        ],
      ),
    );
  }
}
