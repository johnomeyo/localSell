import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Dummy extends StatelessWidget {
  const Dummy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("shop_items").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("Error occured");
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              var doc = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: doc.length,
                  itemBuilder: (context, index) => ListTile(
                        leading: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(doc[index]['imageUrl']),
                                  fit: BoxFit.cover)),
                        ),
                        title: Text(doc[index]['price']),
                      ));
            }),
      ),
    );
  }
}
