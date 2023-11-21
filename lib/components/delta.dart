import 'package:flutter/material.dart';

class SignUpOptions extends StatelessWidget {
  const SignUpOptions({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: Colors.white),
      child: Image.asset(image),
    );
  }
}

// ignore: must_be_immutable
class MyButtons extends StatelessWidget {
   MyButtons({super.key, required this.text, required this.ontap});
  final String text;
   void Function() ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Center(child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),)),
        ),
      ),
    );
  }
}
