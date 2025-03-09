import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:valbury_test/domain/entity/post.dart';
import 'package:valbury_test/screen/post/post_detail_screen.dart';
import 'package:valbury_test/screen/post/post_notifier.dart';

class PostItem extends StatelessWidget {
  final Post postModel;

  const PostItem({super.key, required this.postModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostDetailScreen(postModel: postModel),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              blurRadius: 3,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    postModel.title,
                    style: GoogleFonts.montserrat(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.read<PostNotifier>().updateFavoritePost(postModel);
                  },
                  icon: Icon(Icons.favorite),
                  color: postModel.isFavorite ? Colors.red : Colors.black,
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              postModel.body,
              style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
