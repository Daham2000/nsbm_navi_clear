import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: SizedBox.fromSize(
                  size: Size.fromRadius(60), // Image radius
                  child: Image.network('https://www.whatsappimages.in/wp-content/uploads/2020/05/Bo'
                      'ys-Profile-Images-45.jpg', fit: BoxFit.cover),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(Icons.person),
              SizedBox(width: 30.0,),
              SizedBox(
                width: 200,
                height: 35,
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'John Deo'),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(Icons.email),
              SizedBox(width: 30.0,),
              SizedBox(
                width: 200,
                height: 35,
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'defs@gmail.com'),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(Icons.date_range),
              SizedBox(width: 30.0,),
              SizedBox(
                width: 200,
                height: 35,
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: '2022/03/04'),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
