import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;
  var responseData = ''.obs;
  var token = ''.obs;

  late Box<String> stringBox;

  @override
  void onInit() async {
    super.onInit();
    await Hive.initFlutter(); // Inisialisasi Hive
    stringBox =
        await Hive.openBox<String>('strings'); // Buka Box sebelum digunakan
    loadToken();
  }

  void loadToken() {
    if (stringBox.containsKey('token')) {
      token.value = stringBox.get('token')!;
    }
  }

  void onItemTapped(int index) {
    selectedIndex.value = index;
    if (selectedIndex.value == 0) {
      fetchData();
    }
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/data'),
        headers: {
          'Authorization': 'Bearer ${token.value}',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        responseData.value = jsonData.toString();
      } else {
        print('Failed to load data. Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

 Future<void> createPost(String caption, String imageBase64) async {
    try {
      // decode Imagebase64 to byte
      var imageBytes = base64.decode(imageBase64);

      var request = http.MultipartRequest(
        'PUT',
        Uri.parse('https://r2api.rezultroy.workers.dev/'),
      );

      request.headers['Authorization'] = 'Bearer ${token.value}';
      request.fields['caption'] = caption;
      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          imageBytes,
          filename: 'image.jpg',
        ),
      );

      var response = await request.send();
      // print body
      print(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        print('Post created successfully');
        // snackbar
        Get.snackbar('Success', 'Post created successfully',
            snackPosition: SnackPosition.BOTTOM);
        fetchData();
      } else {
        print('Failed to create post: ${response.statusCode}');
      }
    } catch (error) {
      Get.snackbar('Error', "Failed to create post", snackPosition: SnackPosition.BOTTOM);
      print('Error creating post: $error');
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/signin'),
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final tokenValue = jsonData['token'];

        await stringBox.put('token', tokenValue);

        token.value = tokenValue;
        print('User signed in successfully');
      } else {
        print('Failed to sign in. Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error signing in: $error');
    }
  }
}
