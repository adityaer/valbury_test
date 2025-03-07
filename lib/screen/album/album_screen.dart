import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valbury_test/widget/album_item.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
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
          child: GridView.builder(
            itemCount: 3,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (_, index) {
              return AlbumItem();
            },
          ),
        ),
      ],
    );
  }
}
