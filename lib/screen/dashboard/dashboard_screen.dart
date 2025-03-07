import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valbury_test/screen/album/album_screen.dart';
import 'package:valbury_test/screen/favorite/favorite_screen.dart';
import 'package:valbury_test/screen/post/post_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _bottomNavIndex = 0;

  final List<Widget> _listWidget = [
    const Postscreen(),
    const AlbumScreen(),
    const FavoriteScreen(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.newspaper),
      label: 'Post',
    ),
    BottomNavigationBarItem(icon: Icon(Icons.image_outlined), label: 'Album'),
    BottomNavigationBarItem(icon: Icon(Icons.bookmark_outline), label: 'Favorite'),
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.person_outlined))
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
