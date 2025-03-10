import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:valbury_test/constant/string_constant.dart';
import 'package:valbury_test/helper/helper_online_status.dart';
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

  late HelperOnlineStatus helperOnlineStatus;

  final List<Widget> _listWidget = [
    const Postscreen(),
    const AlbumScreen(),
    const FavoriteScreen(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.newspaper),
      label: StringConstants.post,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.image_outlined),
      label: StringConstants.album,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.bookmark_outline),
      label: StringConstants.favorite,
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

    helperOnlineStatus = GetIt.instance<HelperOnlineStatus>();
    helperOnlineStatus.initConnectivity();
    helperOnlineStatus.subscribeConnectivity();
  }

  @override
  void dispose() {
    helperOnlineStatus.cancelConnectivitySubscription();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _bottomNavIndex, children: _listWidget),
      appBar: AppBar(
        actions: [
          Consumer<HelperOnlineStatus>(
            builder: (context, data, child) {
              var connection = data.connectionStatus;
              var isConnectedToInternet =
                  connection.isNotEmpty &&
                  connection[0] != ConnectivityResult.none;
              return Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: isConnectedToInternet ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    width: 10,
                    height: 10,
                  ),
                  SizedBox(width: 10),
                  Text(
                    isConnectedToInternet
                        ? StringConstants.online
                        : StringConstants.offline,
                    style: GoogleFonts.montserrat(),
                  ),
                ],
              );
            },
          ),
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
