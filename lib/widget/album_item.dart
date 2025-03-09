import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:valbury_test/domain/entity/album.dart';
import 'package:valbury_test/screen/album/album_detail_screen.dart';
import 'package:valbury_test/screen/album/album_notifier.dart';

class AlbumItem extends StatelessWidget {
  final Album albumModel;

  const AlbumItem({super.key, required this.albumModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AlbumDetailScreen(albumModel: albumModel),
          ),
        );
      },
      child: SizedBox(
        width: 200,
        height: 200,
        child: Stack(
          children: [
            Transform.translate(
              offset: Offset(15, 35),
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 3,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Spacer(),
                    Text(
                      albumModel.title,
                      style: GoogleFonts.montserrat(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3)],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  albumModel.albumImagePath,
                  fit: BoxFit.cover,
                  width: 150,
                  height: 150,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Transform.translate(
                offset: Offset(-25, -15),
                child: FloatingActionButton(
                  onPressed: () {
                    context.read<AlbumNotifier>().updateFavoriteAlbum(
                      albumModel,
                    );
                  },
                  mini: true,
                  shape: CircleBorder(),
                  child: Icon(
                    Icons.favorite,
                    color: albumModel.isFavorite ? Colors.red : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
