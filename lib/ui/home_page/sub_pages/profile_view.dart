import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nsbm_navi_clear/db/auth.dart';
import 'package:nsbm_navi_clear/db/model/profile.dart';
import 'package:nsbm_navi_clear/db/profile_api.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String profileImg =
      "https://firebasestorage.googleapis.com/v0/b/navi-clear.appspot.com/o/n.webp?alt=media&token=f906a4f2-5a43-4206-87a3-4aa607b74012";
  String name = "";
  String email = "";
  final TextEditingController _controller = TextEditingController();
  final picker = ImagePicker();
  late File _image;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxWidth: 300,
        maxHeight: 300);
    try {
      if(pickedFile!=null){
        _image = File(pickedFile.path);
      }
    } catch (e) {
      print(e);
    }
  }

  void getUser() async {
    final User? loggedUser = await Auth().getLoggedUser();
    final Profile user = await ProfileApi().getUser(loggedUser?.email);
    setState(() {
      if(user.profilePicture!=""){
        profileImg = user.profilePicture;
      }
      name = user.displayName;
      _controller.text = name;
      email= user.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  showModalBottomSheet(context: context, builder: (builder) {
                    return Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height*0.1,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: InkWell(
                        onTap: (){
                          Navigator.pop(context);
                          getImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Icon(Icons.person),
                            SizedBox(width: 10,),
                            Text("Change profile picture"),
                          ],
                        ),
                      ),
                    );
                  });
                },
                child: ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(60), // Image radius
                    child: Image.network(
                        profileImg,
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.person),
              const SizedBox(
                width: 30.0,
              ),
              SizedBox(
                width: 200,
                height: 35,
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: 'User name'),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.email),
              const SizedBox(
                width: 30.0,
              ),
              SizedBox(
                width: 200,
                height: 35,
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: email),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
