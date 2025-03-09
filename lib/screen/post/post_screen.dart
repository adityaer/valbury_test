import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valbury_test/screen/post/post_notifier.dart';
import 'package:valbury_test/widget/post_item.dart';
import 'package:provider/provider.dart';

class Postscreen extends StatefulWidget {
  const Postscreen({super.key});

  @override
  State<Postscreen> createState() => _PostscreenState();
}

class _PostscreenState extends State<Postscreen> {
  late SharedPreferences prefs;
  var userId = 0;

  @override
  void initState() {
    super.initState();
    getDataLogin();
  }

  Future<void> getDataLogin() async {
    await SharedPreferences.getInstance().then((data) {
      userId = data.getInt('userId') ?? 0;
      Future.microtask(() {
        Provider.of<PostNotifier>(context, listen: false).fetchPostList(userId);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('POSTS', style: GoogleFonts.montserrat(fontSize: 20)),
        ),
        Expanded(
          child: Consumer<PostNotifier>(
            builder: (context, data, child) {
              return RefreshIndicator(
                onRefresh: () async {
                  Provider.of<PostNotifier>(
                    context,
                    listen: false,
                  ).fetchPostList(1);
                },
                child: ListView.builder(
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PostItem(postModel: data.postList[index]),
                    );
                  },
                  itemCount: data.postList.length,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
