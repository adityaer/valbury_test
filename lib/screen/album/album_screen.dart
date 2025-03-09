import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valbury_test/screen/album/album_notifier.dart';
import 'package:valbury_test/widget/album_item.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  late SharedPreferences prefs;
  var userId = 0;

  @override
  void initState() {
    super.initState();

    getDataLogin();
  }

  Future<void> getDataLogin() async {
    prefs = await SharedPreferences.getInstance();
    userId = (prefs.getInt('userId') ?? 0);
    Future.microtask(() {
      Provider.of<AlbumNotifier>(context, listen: false).fetchAlbumList(userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('ALBUMS', style: GoogleFonts.montserrat(fontSize: 20)),
        ),
        Expanded(
          child: Consumer<AlbumNotifier>(
            builder: (context, data, child) {
              return RefreshIndicator(
                onRefresh: () async {
                  Provider.of<AlbumNotifier>(
                    context,
                    listen: false,
                  ).fetchAlbumList(1);
                },
                child: GridView.builder(
                  itemCount: data.albumList.length,
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
                      child: AlbumItem(albumModel: data.albumList[index]),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
