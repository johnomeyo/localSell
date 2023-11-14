import 'package:flutter/material.dart';
import 'package:local_sell/components/alpha.dart';
import 'package:local_sell/components/constants.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            child: Center(
              child: Icon(
                Icons.shopping_bag,
                size: 70,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          DrawerTiles(
              onTap: ()=> Navigator.pop(context),
              child: const Text(
                'S H O P',
                style: TextStyle(color: Colors.black),
              )),
              DrawerTiles(
              onTap: () {},
              child: const Text(
                'F A V O R I T E S',
                style: TextStyle(color: Colors.black),
              )),
              DrawerTiles(
              onTap: () {},
              child: const Text(
                'C A R T',
                style: TextStyle(color: Colors.black),
              )),
              DrawerTiles(
              onTap: () {},
              child: const Text(
                'P R O F I L E',
                style: TextStyle(color: Colors.black),
              )),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: DrawerTiles(
                onTap: () {},
                child: const Text(
                  'E X I T',
                  style: TextStyle(color: Colors.black),
                )),
              ),

        ],
      ),
    );
  }
}
