import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:local_sell/components/constants.dart';
import 'package:local_sell/models/product_model.dart';
import 'package:local_sell/pages/cart_page.dart';
import 'package:local_sell/providers/cart_provider.dart';
import 'package:local_sell/providers/favorite_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.product});
  final Product product;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final sizeController = TextEditingController();
  void call(String phoneNumber) async {
//open the phone app on the user's device
    final call = 'tel:$phoneNumber';
    if (await canLaunchUrl(Uri.parse(call))) {
      await launchUrl(Uri.parse(call));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
            )),
        elevation: 0,
        title: Text(
          "Product Details",
          style: style3,
        ),
        actions: [
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 350,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: style3,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(widget.product.category),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(widget.product.price,
                          style: const TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w600)),
                      const SizedBox(
                        height: 20,
                      ),
                      CarouselSlider(
                        items: widget.product.carouselUrls.map((url) {
                          return Builder(builder: (context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[300],
                              ),
                              child: Image.network(
                                url,
                                fit: BoxFit.cover,
                              ),
                            );
                          });
                        }).toList(),
                        options: CarouselOptions(
                            enlargeCenterPage: true, height: 200),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Size(s): ",
                    style: style3,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    widget.product.size,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Description",
                    style: style3,
                  ),
                  const Spacer(),
                  Text(
                    "Condition",
                    style: style3,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    widget.product.description,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const Spacer(),
                  Text(
                    widget.product.condition,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Divider(
                color: Colors.grey.shade600,
              ),
              Text(
                "Seller Details",
                style: style3,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Username:",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const Spacer(),
                  Text(
                    "@${widget.product.sellerUsername}",
                    style: TextStyle(
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Text(
                    "Phone:",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => call(
                      widget.product.sellerPhone,
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.call, color: Colors.green, size: 20,),
                        const SizedBox(width: 10,),
                        Text(
                          widget.product.sellerPhone,
                          style: TextStyle(
                              color: Colors.grey.shade900,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Consumer<FavoriteProvider>(builder:
                      (BuildContext context, favoriteProvider, Widget? child) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: IconButton(
                          onPressed: () {
                            if (favoriteProvider.isFavorite(widget.product) !=
                                true) {
                              favoriteProvider.addToFavorites(widget.product);
                            }
                            
                          },
                          icon: favoriteProvider.isFavorite(widget.product)
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : const Icon(Icons.favorite_border_outlined)),
                    );
                  }),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Provider.of<CartModel>(context, listen: false)
                          .addToCart(widget.product);
                      var snackBar = SnackBar(
                        backgroundColor: Colors.grey.shade200,
                        content: Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Text('Successfully added to cart')),
                        duration: const Duration(seconds: 2),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                            ),
                            Text(
                              "Add to Cart",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
