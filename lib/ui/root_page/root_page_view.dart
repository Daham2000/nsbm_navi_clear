import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nsbm_navi_clear/db/auth.dart';
import 'package:nsbm_navi_clear/ui/login_page/login_page_view.dart';
import 'package:nsbm_navi_clear/util/assets.dart';

import '../../theme/styled_colors.dart';
import '../home_page/home_page_view.dart';

class RootView extends StatefulWidget {
  const RootView({Key? key}) : super(key: key);

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {

  bool isLoading = true;

  void checkLogin()async{
    final User? user = await Auth().getLoggedUser();
    if(user!=null){
      setState(() {
        isLoading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePageView()),
      );
    }else{
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPageView()),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading ? Container() : Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            Assets.logo,
            height: 60,
          ),
          const SizedBox(height: 7.0,),
          const CircularProgressIndicator(
            color: StyledColor.blurPrimary,
          ),
        ],
      ),
    );
  }
}
