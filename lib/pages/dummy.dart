import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerExample extends StatefulWidget {
  @override
  _ImagePickerExampleState createState() => _ImagePickerExampleState();
}

class _ImagePickerExampleState extends State<ImagePickerExample> {
  List<XFile>? _imageList;

  Future<void> _pickImages() async {
    List<XFile>? result = await ImagePicker().pickMultiImage();
    setState(() {
      _imageList = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _pickImages,
              child: const Text('Pick Images'),
            ),
            if (_imageList != null)
              Column(
                children: _imageList!
                    .map((XFile image) => Image.file(File(image.path)))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}
