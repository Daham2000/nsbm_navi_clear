import 'package:flutter/material.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({Key? key}) : super(key: key);

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          children:  [
            const SizedBox(
              width: 120,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
                child: Text(
                  "From where:",
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.6,
              height: 40,
              child: const TextField(
                  decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide: BorderSide(color: Colors.grey, width: 0.8),
                ),
              )),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Row(
            children: [
              const SizedBox(
                width: 120,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
                  child: Text(
                    "To where:",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.6,
                height: 40,
                child: const TextField(
                    decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 0.8),
                  ),
                )),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {},
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.navigation),
          ),
        ),
        SizedBox(height: 10.0,),
        Image(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.55,
          fit: BoxFit.fill,
          image: const NetworkImage(
            "https://www.csth.health.gov.lk/wp-content/uploads/2015/07/DSC03113-e1492752901317.jpg",
          ),
        )
      ],
    );
  }
}
