import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nsbm_navi_clear/db/auth.dart';
import 'package:nsbm_navi_clear/theme/styled_colors.dart';
import 'package:nsbm_navi_clear/ui/home_page/sub_pages/category_view.dart';
import 'package:nsbm_navi_clear/ui/home_page/sub_pages/favourite_view.dart';
import 'package:nsbm_navi_clear/ui/home_page/sub_pages/profile_view.dart';
import 'package:nsbm_navi_clear/ui/login_page/login_page_view.dart';
import 'package:nsbm_navi_clear/ui/widgets/basic_widget.dart';

import '../root_page/root_bloc.dart';
import '../root_page/root_event.dart';
import '../root_page/root_state.dart';
import 'sub_pages/navigation_view.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

String name = "";

class _HomePageViewState extends State<HomePageView> {
  int _selectedIndex = 0;
  late RootBloc rootBloc;
  static final List<Widget> _widgetOptions = <Widget>[
    CategoryView(),
    const NavigationView(),
    const FavouriteView(),
    const ProfileView(),
  ];

  @override
  void initState() {
    rootBloc = BlocProvider.of<RootBloc>(context);
    super.initState();
  }

  void _onItemTapped(int index) {
    rootBloc.add(SearchCategory(""));
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final rootBloc = BlocProvider.of<RootBloc>(context);

    return BlocBuilder<RootBloc, RootState>(
        buildWhen: (pre, current) => pre.query != current.query ||
            pre.toWhere != current.toWhere,
        builder: (context, state) {
          if(state.toWhere!=''){
            if(state.isSelectedAgain==false){
              _selectedIndex = 1;
            }
          }
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
                            child: TextField(
                              onChanged: (v) {
                                rootBloc.add(SearchCategory(v));
                              },
                              decoration: const InputDecoration(
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
                  _selectedIndex != 0
                      ? GestureDetector(
                          onTap: () {
                            Auth().logout();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPageView()),
                            );
                          },
                          child: const AppBarAction())
                      : Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: InkWell(
                              onTap: () {},
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
        });
  }
}
