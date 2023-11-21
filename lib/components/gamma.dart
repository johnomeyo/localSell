import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileTiles extends StatelessWidget {
  const ProfileTiles({
    super.key,
    required this.title,
    required this.text,
  });
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
          Divider(
            color: Colors.grey.shade600,
          )
        ],
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField(
      {super.key,
      required this.title,
      required this.hintText,
      required this.prefixIcon,
      this.suffixIcon,
      required this.controller});
  final String title;
  final TextEditingController controller;
  final String hintText;
  final Widget prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(15)),
              child: TextField(
                // textAlign: TextAlign.center,
                controller: controller,
                cursorColor: Colors.red,
                decoration: InputDecoration(
                    prefixIcon: prefixIcon,
                    suffixIcon: suffixIcon,
                    prefixIconColor: Colors.grey.shade500,
                    suffixIconColor: Colors.grey.shade500,
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: GoogleFonts.lato(color: Colors.grey.shade500)),
              ))
        ],
      ),
    );
  }
}

class MySwitch extends StatefulWidget {
  const MySwitch({super.key});

  @override
  State<MySwitch> createState() => _MySwitchState();
}

bool switchValue = false;

class _MySwitchState extends State<MySwitch> {
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: switchValue,
      onChanged: (bool value) {
        setState(() {
          switchValue = value;
        });
      },
      activeTrackColor:
          Colors.red.shade100, // Set the active track color to red
      activeColor: Colors.red,
    );
  }
}
