import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/Controllers/HomeCr.dart';
import 'dart:convert';
import 'dart:io';

class CreatePostView extends StatefulWidget {
  @override
  _CreatePostViewState createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  final TextEditingController _captionController = TextEditingController();
  XFile? _selectedImage;
  String? _imageBase64;

  final HomeController controller = Get.find();

  void _submitPost() {
    final caption = _captionController.text;

    if (caption.isNotEmpty && _imageBase64 != null) {
      controller.createPost(caption, _imageBase64!);
      Get.back();
    } else {
        Get.snackbar('Error', "Please enter a caption and select an image", snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        final base64String = base64Encode(bytes);

        setState(() {
          _selectedImage = pickedFile;
          _imageBase64 = base64String;
        });
      } else {
        print('No image selected');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _captionController,
                decoration: InputDecoration(labelText: 'Caption'),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: _getImage,
                child: Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: _selectedImage == null
                      ? Icon(Icons.add_a_photo, size: 50, color: Colors.grey)
                      : Image.file(
                          File(_selectedImage!.path),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitPost,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
