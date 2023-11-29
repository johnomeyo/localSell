import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:local_sell/pages/search_page.dart';
import 'package:local_sell/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartTiles extends StatefulWidget {
  const CartTiles(
      {super.key,
      required this.name,
      required this.category,
      required this.price,
      required this.imageUrl,
      t});
  final String name;
  final String category;
  final String price;
  final String imageUrl;

  @override
  State<CartTiles> createState() => _CartTilesState();
}

class _CartTilesState extends State<CartTiles> {
  int counter = 1;
  void shit() {}
  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (BuildContext context, cart, Widget? child) {
        return Slidable(
          endActionPane: ActionPane(motion: const StretchMotion(), children: [
            SlidableAction(
                label: "Delete",
                icon: Icons.delete,
                backgroundColor: Colors.black,
                onPressed: (BuildContext context) {
                  
                })
          ]),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer(
              builder: (BuildContext context, cartProvider, Widget? child) {
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                image: NetworkImage(widget.imageUrl),
                                fit: BoxFit.cover)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.category,
                            style: const TextStyle(fontSize: 10),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(widget.price,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red)),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                counter++;
                              });
                            },
                            icon: const Icon(Icons.add_circle),
                          ),
                          Text(counter.toString()),
                          IconButton(
                            onPressed: () {
                              if (counter > 1) {
                                setState(() {
                                  counter--;
                                });
                              }
                            },
                            icon: Icon(
                              Icons.remove_circle,
                              color: counter > 1
                                  ? Colors.black
                                  : Colors.grey.shade500,
                            ),
                          ),
                        ],
                      )
                    ]),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class FavoriteTile extends StatelessWidget {
  const FavoriteTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: const DecorationImage(
                      image: NetworkImage(
                          "https://images.unsplash.com/photo-1549298916-f52d724204b4?q=80&w=1626&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                      fit: BoxFit.cover)),
            ),
            const SizedBox(
              width: 10,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nike Air Force 1",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Men's shoe",
                  style: TextStyle(fontSize: 10),
                ),
                SizedBox(
                  height: 5,
                ),
                Text("Ksh 2300",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.red)),
              ],
            ),
            const Spacer(),
          ]),
        ),
      ),
    );
  }
}

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SearchPage())),
        icon: const Icon(
          Icons.search,
          color: Colors.black,
        ));
  }
}
