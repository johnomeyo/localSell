// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_sell/components/delta.dart';
import 'package:local_sell/components/gamma.dart';
import 'package:local_sell/pages/shop.dart';

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
  // String selectedPath = "";
  // String imageUrl = "";

  // selectImageFromGallery() async {
  //   XFile? file = await ImagePicker()
  //       .pickImage(source: ImageSource.gallery, imageQuality: 100);
  //   if (file != null) {
  //     return file.path;
  //   } else {
  //     return '';
  //   }
  // }

  // selectImageFromCamera() async {
  //   XFile? file = await ImagePicker()
  //       .pickImage(source: ImageSource.camera, imageQuality: 100);
  //   if (file != null) {
  //     return file.path;
  //   } else {
  //     return '';
  //   }
  // }
  List<XFile> _imageList = [];
  final List<String> urlList = [];

  Future<void> _pickImages() async {
    List<XFile>? result = await ImagePicker().pickMultiImage();
    setState(() {
      _imageList = result;
    });
  }

  uploadPost() async {
    // if (selectedPath == '') return;
    // String uniqueName = DateTime.now().microsecondsSinceEpoch.toString();
    // Reference referenceRoot = FirebaseStorage.instance.ref();
    // Reference referenceDirImages = referenceRoot.child("images");
    // Reference imageToUpload = referenceDirImages.child(uniqueName);
    // try {
    //   await imageToUpload.putFile(File(selectedPath));
    //   imageUrl = await imageToUpload.getDownloadURL();
    // } catch (e) {
    //   Text("An error $e occurred");
    // }
    for (var img in _imageList) {
      var file = File(img.path);
      var fileName = DateTime.now().millisecondsSinceEpoch.toString();
      var reference = FirebaseStorage.instance.ref().child('photos/$fileName');
      await reference.putFile(file);
      String downloadUrl = await reference.getDownloadURL();
      urlList.add(downloadUrl);
    }

    await FirebaseFirestore.instance.collection("shop_items").add({
      "price": priceController.text,
      "title": titleController.text,
      "category": categoryController.text,
      "description": descriptionController.text,
      "condition": conditionController.text,
      "size": sizeController.text,
      "measurement": measurementController.text,
      "imageUrls": urlList,
      'displayPhoto':urlList[0],
      "timestamp": DateTime.now()
    });
  }

  @override
  void initState() {
    titleController.clear();
    priceController.clear();
    descriptionController.clear();
    sizeController.clear();
    measurementController.clear();
    conditionController.clear();
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
        body: SingleChildScrollView(
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
                    text: "Upload",
                    ontap: () {
                      if (priceController.text.isNotEmpty &&
                          titleController.text.isNotEmpty &&
                          descriptionController.text.isNotEmpty &&
                          sizeController.text.isNotEmpty &&
                          conditionController.text.isNotEmpty &&
                          categoryController.text.isNotEmpty &&
                          // selectedPath.isNotEmpty &&
                          measurementController.text.isNotEmpty) {
                        uploadPost();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Shop()));
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
        ));
  }
}
/*
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[200]),
                      child: selectedPath == ""
                          ? GestureDetector(
                              onTap: () async {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text(
                                            "Choose an image from...!!!",
                                            style: GoogleFonts.lato(
                                                textStyle: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                          content: SingleChildScrollView(
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    selectedPath =
                                                        await selectImageFromGallery();
                                                    if (selectedPath != "") {
                                                      Navigator.pop(context);
                                                      setState(() {});
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                                  content: Text(
                                                                      "No image selected")));
                                                    }
                                                  },
                                                  child: Card(
                                                    child: Column(
                                                      children: [
                                                        Image.asset(
                                                          "assets/gallery.png",
                                                          height: 100,
                                                          width: 100,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 10),
                                                          child: Text(
                                                            'Gallery',
                                                            style: GoogleFonts.lato(
                                                                textStyle: const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    await selectImageFromCamera();
                                                    if (selectedPath != "") {
                                                      Navigator.pop(context);
                                                      setState(() {});
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                                  content: Text(
                                                                      "No image selected")));
                                                    }
                                                  },
                                                  child: Card(
                                                    child: Column(
                                                      children: [
                                                        Image.asset(
                                                          "assets/camera.png",
                                                          height: 100,
                                                          width: 100,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 10),
                                                          child: Text(
                                                            'Camera',
                                                            style: GoogleFonts.lato(
                                                                textStyle: const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/post.png"),
                                  const Text("Upload image"),
                                ],
                              ),
                            )
                          : Image.file(
                              File(selectedPath),
                              fit: BoxFit.cover,
                            )),
                ),
              ),

*/