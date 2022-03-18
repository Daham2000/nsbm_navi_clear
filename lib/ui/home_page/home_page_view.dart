import 'package:flutter/material.dart';
import 'package:nsbm_navi_clear/ui/home_page/sub_pages/category_view.dart';
import 'package:nsbm_navi_clear/ui/login_page/login_page_view.dart';
import 'package:nsbm_navi_clear/ui/widgets/basic_widget.dart';

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
    Text(
      'Under developing',
      style: optionStyle,
    ),
    Text(
      'Under developing',
      style: optionStyle,
    ),
    Text(
      'Under developing',
      style: optionStyle,
    ),
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
          bottom: PreferredSize(
            preferredSize: const Size(200, 50),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 12.0),
              child: Container(
                alignment: Alignment.centerLeft,
                color: Colors.white,
                child: const TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Search'),
                ),
              ),
            ),
          ),
          actions: [GestureDetector(onTap: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPageView()),
            );
          },child: const AppBarAction())],
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
            label: 'Person',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
