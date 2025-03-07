import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  'Titleeeeeeeeeeeeeeeeeeee Titleeeeeeeeeeeeeeeeeeee Titleeeeeeeeeeeeeeeeeeee Titleeeeeeeeeeeeeeeeeeee',
                  style: GoogleFonts.montserrat(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.heart_broken)),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Bodyyyyyyyyyyyy Bodyyyyyyyyyyyy Bodyyyyyyyyyyyy Bodyyyyyyyyyyyy Bodyyyyyyyyyyyy Bodyyyyyyyyyyyy',
            style: GoogleFonts.montserrat(
              fontSize: 15,
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
