import 'package:flutter/material.dart';
import 'package:personal_profile_app/screens/gallery_screen.dart';
import 'package:personal_profile_app/screens/home_screen.dart';
import 'package:personal_profile_app/screens/profile_screen.dart';
import 'package:personal_profile_app/screens/settings_screen.dart';

class HomeBottomNavigationBar extends StatefulWidget {
  HomeBottomNavigationBar() : super(key: navKey);

  static final GlobalKey<_HomeBottomNavigationBarState> navKey =
      GlobalKey<_HomeBottomNavigationBarState>();

  @override
  State<HomeBottomNavigationBar> createState() =>
      _HomeBottomNavigationBarState();
}

class _HomeBottomNavigationBarState extends State<HomeBottomNavigationBar> {
  int selectScreen = 0;
  List<Widget> screens = [
    HomeScreen(),
    GalleryScreen(),
    SettingsScreen(),
    ProfileScreen(),
  ];

  void updateIndex(int index) {
    setState(() {
      selectScreen = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectScreen],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).cardColor,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).textTheme.bodySmall?.color,
        showUnselectedLabels: true,
        currentIndex: selectScreen,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: 'Gallery',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          updateIndex(index);
        },
      ),
    );
  }
}
