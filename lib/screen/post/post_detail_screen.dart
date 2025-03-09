import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:valbury_test/domain/entity/post.dart';
import 'package:valbury_test/screen/post/post_notifier.dart';

class PostDetailScreen extends StatefulWidget {
  final Post postModel;

  const PostDetailScreen({super.key, required this.postModel});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<PostNotifier>(
        context,
        listen: false,
      ).fetchCommentPostList(widget.postModel.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            buildHeaderPostDetail(widget.postModel),
            SizedBox(height: 10),
            Text(
              widget.postModel.body,
              style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.italic,
              ),
            ),
            Spacer(),
            SizedBox(height: 20),
            Text('Comments', style: GoogleFonts.montserrat(fontSize: 18)),
            SizedBox(height: 10),
            SizedBox(height: 120, child: buildCommentList()),
          ],
        ),
      ),
    );
  }

  Widget buildHeaderPostDetail(Post post) {
    var isFavorite = post.isFavorite;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            widget.postModel.title,
            style: GoogleFonts.montserrat(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            context.read<PostNotifier>().updateFavoritePost(post);
            setState(() {
              isFavorite = !isFavorite;
            });
          },
          icon: Icon(
            Icons.favorite,
            size: 40,
            color: isFavorite ? Colors.red : Colors.black,
          ),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
        ),
      ],
    );
  }

  Widget buildCommentList() {
    return Consumer<PostNotifier>(
      builder: (context, data, child) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.commentPostList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey, width: 2),
                ),
                child: Text(
                  data.commentPostList[index].body ?? '',
                  style: GoogleFonts.montserrat(fontStyle: FontStyle.italic),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
