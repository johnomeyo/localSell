import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_sell/components/shimmers/sneakertile.dart';

class ImagePickerExample extends StatefulWidget {
  const ImagePickerExample({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ImagePickerExampleState createState() => _ImagePickerExampleState();
}

class _ImagePickerExampleState extends State<ImagePickerExample> {
  List<XFile> _imageList = [];
  final List<String> urlList = [];

  Future<void> _pickImages() async {
    List<XFile>? result = await ImagePicker().pickMultiImage();
    setState(() {
      _imageList = result;
    });
  }

  Future<void> uploadImages() async {
    for (var img in _imageList) {
      var file = File(img.path);
      var fileName = DateTime.now().millisecondsSinceEpoch.toString();
      var reference = FirebaseStorage.instance.ref().child('photos/$fileName');
      await reference.putFile(file);
      String downloadUrl = await reference.getDownloadURL();
      urlList.add(downloadUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker Example'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ElevatedButton(
            //   onPressed: () async {
            //     await _pickImages();
            //     await uploadImages();
            //   },
            //   child: const Text('Pick Images'),
            // ),
            // CarouselSlider(
            //   items: urlList.map((image) {
            //     return Image.network(image);
            //   }).toList(),
            //   options: CarouselOptions(
            //     height: 400.0,
            //     enlargeCenterPage: true,
            //     aspectRatio: 16 / 9,
            //   ),
            // ),
            SneakerTileShimmer()
          ],
        ),
      ),
    );
  }
}
