import 'package:flutter/material.dart';
import 'package:valbury_test/screen/album/album_screen.dart';
import 'package:valbury_test/screen/post/post_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  var tabList = [const Tab(text: 'Post'), const Tab(text: 'Album')];

  int _selectedIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: tabList.length, vsync: this);
    _tabController?.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: TabBar(
            unselectedLabelColor: Colors.black.withOpacity(0.5),
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            tabs: tabList,
            controller: _tabController,
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [Postscreen(), AlbumScreen()],
      ),
    );
  }
}
