import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valbury_test/screen/album/album_screen.dart';
import 'package:valbury_test/screen/favorite/favorite_screen.dart';
import 'package:valbury_test/screen/post/post_screen.dart';
import 'package:valbury_test/screen/profile/profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  int _bottomNavIndex = 0;

  final List<Widget> _listWidget = [
    const Postscreen(),
    const AlbumScreen(),
    const FavoriteScreen(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'Post'),
    BottomNavigationBarItem(icon: Icon(Icons.image_outlined), label: 'Album'),
    BottomNavigationBarItem(
      icon: Icon(Icons.bookmark_outline),
      label: 'Favorite',
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _bottomNavIndex, children: _listWidget),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
            icon: Icon(Icons.person_outlined),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        currentIndex: _bottomNavIndex,
        selectedLabelStyle: GoogleFonts.montserrat(
          color: Colors.blue,
          fontSize: 14,
        ),
        unselectedLabelStyle: GoogleFonts.montserrat(fontSize: 12),
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }
}
