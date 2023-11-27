import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_sell/components/alpha.dart';
import 'package:local_sell/components/beta.dart';
import 'package:local_sell/components/constants.dart';
import 'package:local_sell/components/drawer.dart';
import 'package:local_sell/models/product_model.dart';
import 'package:local_sell/pages/cart_page.dart';
import 'package:local_sell/pages/new_arrivals.dart';

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
        actions: [
          const SearchButton(),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CartPage())),
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black,
                )),
          )
        ],
      ),
      drawer: const MyDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Shoes Store",
              style: style1,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: containerBackground,
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      image: NetworkImage(
                          "https://images.unsplash.com/photo-1579338559194-a162d19bf842?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fHNuZWFrZXJzfGVufDB8fDB8fHww"),
                      fit: BoxFit.cover)),
              height: 200,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Air Jordan',
                  style: style2,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "New Arrivals",
                  style: style2,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewArrivalsPage())),
                  child: const Row(
                    children: [
                      Text(
                        "See all ",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.red,
                        size: 15,
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("shop_items")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Network Error");
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  var docs = snapshot.data!.docs;
                  return Expanded(
                      child: GridView.builder(
                    itemCount: 4,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemBuilder: (context, index) => SneakerTile(
                      product: Product(
                        name: docs[index]['title'],
                        price: docs[index]['price'],
                        description: docs[index]['description'],
                        imageUrl: docs[index]['imageUrl'],
                        size: docs[index]['size'],
                      ),
                    ),
                  ));
                }),
          ]),
        ),
      ),
    );
  }
}
