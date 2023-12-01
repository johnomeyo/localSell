import 'package:flutter/material.dart';
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
        return Padding(
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
        );
      },
    );
  }
}

class FavoriteTile extends StatelessWidget {
  const FavoriteTile(
      {super.key,
      required this.name,
      required this.price,
      required this.category,
      required this.imageUrl});
  final String name;
  final String price;
  final String category;
  final String imageUrl;
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
                  image: DecorationImage(
                      image: NetworkImage(imageUrl), fit: BoxFit.cover)),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  category,
                  style: const TextStyle(fontSize: 10),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(price,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.red)),
              ],
            ),
            const Spacer(),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.delete_outlined,
                  color: Colors.red,
                ))
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
