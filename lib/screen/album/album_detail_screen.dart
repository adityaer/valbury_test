import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:valbury_test/domain/entity/album.dart';
import 'package:valbury_test/screen/album/album_notifier.dart';

class AlbumDetailScreen extends StatefulWidget {
  final Album albumModel;

  const AlbumDetailScreen({super.key, required this.albumModel});

  @override
  State<AlbumDetailScreen> createState() => _AlbumDetailScreenState();
}

class _AlbumDetailScreenState extends State<AlbumDetailScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<AlbumNotifier>(
        context,
        listen: false,
      ).fetchAlbumDetailList(widget.albumModel.id);
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
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            buildHeaderAlbumDetail(widget.albumModel),
            SizedBox(height: 10),
            Expanded(
              child: Consumer<AlbumNotifier>(
                builder: (context, data, child) {
                  return GridView.builder(
                    itemCount: data.albumDetailList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: buildAlbumDetailItem(data, index),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildAlbumDetailItem(AlbumNotifier data, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3)],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Image.network(
              data.albumDetailList[index].albumImagePath ?? '',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              data.albumDetailList[index].title ?? '',
              style: GoogleFonts.montserrat(fontSize: 15),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Row buildHeaderAlbumDetail(Album album) {
    var isFavorite = album.isFavorite;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            widget.albumModel.title,
            style: GoogleFonts.montserrat(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            context.read<AlbumNotifier>().updateFavoriteAlbum(album);
            setState(() {
              isFavorite = !isFavorite;
            });
          },
          icon: Icon(
            Icons.favorite,
            size: 40,
            color: widget.albumModel.isFavorite ? Colors.red : Colors.black,
          ),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
        ),
      ],
    );
  }
}
