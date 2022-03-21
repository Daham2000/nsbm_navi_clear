import 'package:flutter/material.dart';
import 'package:nsbm_navi_clear/db/location_api.dart';
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

class SubCategory extends StatelessWidget {
  dynamic i;
  String itemKey = "subItems";
  String name = "";
  List<dynamic> favList = [];

  SubCategory(dynamic item, String n,List<dynamic> favListParam, {Key? key}) : super(key: key) {
    i = item;
    name = n;
    favList = favListParam;
    if(item["subItems"]==null){
      itemKey = "subitems";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var t in i[itemKey])
            favList.isNotEmpty ? favList.contains(t) ? Card(
              elevation: 1,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      t,
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.start,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.navigation,
                            color: StyledColor.blurPrimary,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        InkWell(
                          onTap: () async {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Updating...'),
                              backgroundColor: StyledColor.blurPrimary,
                            ));
                            await LocationApi().updateLocationFav(name, t);
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          },
                          child: const Icon(
                            Icons.favorite,
                            color: StyledColor.googleBtn,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ) : Container() :
            Card(
              elevation: 1,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      t,
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.start,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.navigation,
                            color: StyledColor.blurPrimary,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        InkWell(
                          onTap: () async {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Updating...'),
                              backgroundColor: StyledColor.blurPrimary,
                            ));
                            await LocationApi().updateLocationFav(name, t);
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          },
                          child: const Icon(
                            Icons.favorite,
                            color: StyledColor.googleBtn,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
