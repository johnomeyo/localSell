import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileTiles extends StatelessWidget {
  const ProfileTiles({super.key, required this.title, required this.text});
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            text,
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(
            height: 10,
          ),
           Divider(color: Colors.grey.shade600,)
        ],
      ),
    );
  }
}
