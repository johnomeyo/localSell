// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_sell/components/delta.dart';
import 'package:local_sell/components/gamma.dart';
import 'package:local_sell/main.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final categoryController = TextEditingController();
  final sizeController = TextEditingController();
  final conditionController = TextEditingController();
  final measurementController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;
  bool isUploading = false;
  List<XFile> _imageList = [];
   List<String> urlList = [];

  Future<void> _pickImages() async {
    List<XFile>? result = await ImagePicker().pickMultiImage();
    setState(() {
      _imageList = result;
    });
  }

  uploadPost(
    String price,
    String title,
    String category,
    String description,
    String condition,
    String size,
    String measurement,
    String sellerUsername,
    String sellerPhone,
  ) async {
    for (var img in _imageList) {
      var file = File(img.path);
      var fileName = DateTime.now().millisecondsSinceEpoch.toString();
      var reference = FirebaseStorage.instance.ref().child('photos/$fileName');
      await reference.putFile(file);
      String downloadUrl = await reference.getDownloadURL();
      urlList.add(downloadUrl);
    }

    await FirebaseFirestore.instance.collection("shop_items").add({
      "price": price,
      "title": title,
      "category": category,
      "description": description,
      "condition": condition,
      "size": size,
      "measurement": measurement,
      "imageUrls": urlList,
      'displayPhoto': urlList[0],
      "timestamp": DateTime.now(),
      "sellerUsername": sellerUsername,
      "sellerPhone": sellerPhone,
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MyHomePage()));
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    categoryController.dispose();
    categoryController.dispose();
    sizeController.dispose();
    conditionController.dispose();
    measurementController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    isUploading = false;
    urlList = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade100,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Create a post",
            style: GoogleFonts.lato(
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(
                Icons.check_circle,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser?.email)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasError) {
              return const Text("An error occured");
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              );
            }
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _imageList.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                              height: 300,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () async {
                                    await _pickImages();
                                  },
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      Image.asset('assets/post.png'),
                                      const Text("Upload Images"),
                                    ],
                                  ),
                                ),
                              )),
                        )
                      : CarouselSlider(
                          items: _imageList.map((image) {
                            return Image.file(File(image.path));
                          }).toList(),
                          options: CarouselOptions(
                            height: 300.0,
                            enlargeCenterPage: true,
                            aspectRatio: 16 / 9,
                          ),
                        ),
                  UploadPageTextBox(
                    field: 'Title',
                    fieldController: titleController,
                    hintText: 'Enter the name or title of the item',
                  ),
                  UploadPageTextBox(
                    field: 'Description',
                    fieldController: descriptionController,
                    hintText: 'Give a brief description of the item.',
                  ),
                  UploadPageTextBox(
                    field: 'Price',
                    fieldController: priceController,
                    hintText: 'How much is the item?',
                  ),
                  UploadPageTextBox(
                    field: 'Category',
                    fieldController: categoryController,
                    hintText: 'Eg, Men\'s shoes,kids\'s clothes, gaming',
                  ),
                  UploadPageTextBox(
                    field: 'Size',
                    fieldController: sizeController,
                    hintText: 'What is the size of the item?',
                  ),
                  UploadPageTextBox(
                    field: 'Condition',
                    fieldController: conditionController,
                    hintText: 'E.g., new, used, refurbished',
                  ),
                  UploadPageTextBox(
                    field: 'Measurements',
                    fieldController: measurementController,
                    hintText: 'Provide any relevant measurements of the item.',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: MyButtons(
                        text: isUploading ? "Uploading..." : "Upload",
                        ontap: () {
                          setState(() {
                            isUploading = true;
                          });
                          if (priceController.text.isNotEmpty &&
                              titleController.text.isNotEmpty &&
                              descriptionController.text.isNotEmpty &&
                              sizeController.text.isNotEmpty &&
                              conditionController.text.isNotEmpty &&
                              categoryController.text.isNotEmpty &&
                              measurementController.text.isNotEmpty) {
                            uploadPost(
                              priceController.text,
                              titleController.text,
                              categoryController.text,
                              descriptionController.text,
                              conditionController.text,
                              sizeController.text,
                              measurementController.text,
                              userData['username'],
                              userData['phone'],
                            );
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => const SizedBox(
                                    height: 50,
                                    child: AlertDialog(
                                      content: Text(
                                          "Please fill in all the required values :)"),
                                    )));
                          }
                        }),
                  )
                ],
              ),
            );
          },
        ));
  }
}
