import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valbury_test/widget/post_item.dart';

class Postscreen extends StatefulWidget {
  const Postscreen({super.key});

  @override
  State<Postscreen> createState() => _PostscreenState();
}

class _PostscreenState extends State<Postscreen> {
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
          child: ListView.builder(
            itemBuilder: (_, index) {
              return PostItem();
            },
            itemCount: 2,
          ),
        ),
      ],
    );
  }
}
