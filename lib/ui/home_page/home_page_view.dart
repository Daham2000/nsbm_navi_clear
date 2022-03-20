import 'package:flutter/material.dart';
import 'package:nsbm_navi_clear/db/auth.dart';
import 'package:nsbm_navi_clear/theme/styled_colors.dart';
import 'package:nsbm_navi_clear/ui/home_page/sub_pages/category_view.dart';
import 'package:nsbm_navi_clear/ui/home_page/sub_pages/favourite_view.dart';
import 'package:nsbm_navi_clear/ui/home_page/sub_pages/profile_view.dart';
import 'package:nsbm_navi_clear/ui/login_page/login_page_view.dart';
import 'package:nsbm_navi_clear/ui/widgets/basic_widget.dart';

import 'sub_pages/navigation_view.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Scrollbar(child: CategoryView()),
    NavigationView(),
    FavouriteView(),
    ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          leadingWidth: 110,
          elevation: 0,
          title: _selectedIndex == 0
              ? PreferredSize(
                  preferredSize: const Size(200, 50),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 12.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      color: Colors.white,
                      child: const TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Search'),
                      ),
                    ),
                  ),
                )
              : PreferredSize(
                  preferredSize: const Size(200, 0),
                  child: Container(),
                ),
          actions: [
            _selectedIndex != 0 ? GestureDetector(
                onTap: () {
                  Auth().logout();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginPageView()),
                  );
                },
                child: const AppBarAction()) :
            Padding(
               padding: const EdgeInsets.only(right: 10.0),
               child: InkWell(
                 onTap: (){},
                  child: const Icon(
                    Icons.search,
                    color: StyledColor.blurPrimary,
                  )),
             )
          ],
          leading: const AppBarLogo()),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.navigation),
            label: 'Navigation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[500],
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
