import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:socio_app/presentation/page/curd_feed_page.dart';
import 'package:socio_app/presentation/page/home_page.dart';
import 'package:socio_app/presentation/page/profile_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  var _selectedTab = _SelectedTab.home;
  final GlobalKey<HomePageState> _homeKey = GlobalKey();
  final GlobalKey<CrudPageState> _createFeedKey = GlobalKey();
  final GlobalKey<ProfilePageState> _profileKey = GlobalKey();

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });

    // Memanggil initState manual jika perlu
    switch (_selectedTab) {
      case _SelectedTab.home:
        _homeKey.currentState?.initState();
        break;
      case _SelectedTab.add:
        _createFeedKey.currentState?.initState();
        break;
      case _SelectedTab.person:
        _profileKey.currentState?.initState();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _SelectedTab.values.indexOf(_selectedTab),
        children: [
          HomePage(key: _homeKey),
          CrudPage(key: _createFeedKey),
          ProfilePage(key: _profileKey),
        ],
      ),
      bottomNavigationBar: CrystalNavigationBar(
        currentIndex: _SelectedTab.values.indexOf(_selectedTab),
        height: 10,
        unselectedItemColor: Colors.blue[500],
        backgroundColor: Colors.blue.withOpacity(0.1),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            blurRadius: 4,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
        onTap: _handleIndexChanged,
        items: [
          CrystalNavigationBarItem(
            icon: IconlyBold.home,
            unselectedIcon: IconlyLight.home,
            selectedColor: Colors.blue,
          ),
          CrystalNavigationBarItem(
            icon: IconlyBold.plus,
            unselectedIcon: IconlyLight.plus,
            selectedColor: Colors.blue,
          ),
          CrystalNavigationBarItem(
            icon: IconlyBold.user_2,
            unselectedIcon: IconlyLight.user,
            selectedColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}

enum _SelectedTab {
  home,
  // favorite,
  add,
  // search,
  person,
}
