import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_sell/components/constants.dart';
import 'package:local_sell/components/drawer.dart';

class Shop extends StatelessWidget {
  const Shop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Shop',
          style: GoogleFonts.aBeeZee(color: Colors.black, fontSize: 20),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: const MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Text(
            "Shoes Store",
            style: style1,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(color: containerBackground),
            height: 200,
            width: double.infinity,
            child: Text('Air Jordan'),
          )
        ]),
      ),
    );
  }
}
