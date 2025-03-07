import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlbumItem extends StatelessWidget {
  const AlbumItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Spacer(),
                  Text(
                    'Ini adalah albummmmmm', style: GoogleFonts.montserrat(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              'https://images.pexels.com/photos/414061/pexels-photo-414061.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
              fit: BoxFit.cover,
              width: 150,
              height: 150,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Transform.translate(
              offset: Offset(-25, -15),
              child: FloatingActionButton(
                onPressed: () {},
                mini: true,
                shape: CircleBorder(),
                child: Icon(Icons.heart_broken),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
