import 'package:flutter/material.dart';
import 'package:nsbm_navi_clear/theme/styled_colors.dart';
import 'package:nsbm_navi_clear/util/assets.dart';

class AppBarAction extends StatelessWidget {
  const AppBarAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(right: Assets.paddingAppbar),
      child: InkWell(
          child: Icon(
        Icons.logout,
        color: StyledColor.blurPrimary,
      )),
    );
  }
}

class AppBarLogo extends StatelessWidget {
  const AppBarLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: Assets.paddingAppbar),
      child: Image(
        height: Assets.heightAppBarLogo,
        image: AssetImage(Assets.logo),
      ),
    );
  }
}

