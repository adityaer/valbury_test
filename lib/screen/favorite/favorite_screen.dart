import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valbury_test/screen/album/album_notifier.dart';
import 'package:valbury_test/widget/album_item.dart';

import '../../widget/post_item.dart';
import '../post/post_notifier.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  var tabList = [const Tab(text: 'Post'), const Tab(text: 'Album')];

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
        children: [
          Consumer<PostNotifier>(
            builder: (context, data, child) {
              return ListView.builder(
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PostItem(postModel: data.postFavoriteList[index]),
                  );
                },
                itemCount: data.postFavoriteList.length,
              );
            },
          ),
          Consumer<AlbumNotifier>(
            builder: (context, data, child) {
              return GridView.builder(
                itemCount: data.albumFavoriteList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                      bottom: 25,
                    ),
                    child: AlbumItem(albumModel: data.albumFavoriteList[index]),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
