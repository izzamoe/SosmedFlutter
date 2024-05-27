import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:http/http.dart' as http;
import 'package:myapp/Pages/HomePages.dart';
import 'dart:convert';

import 'package:myapp/Pages/home_view.dart';

class WelcomeController extends GetxController {
  var strings = <String>[].obs;
  late Box<String> stringBox;


  // init pada awal init login
 @override
  void onInit() async {
    super.onInit();
    await Hive.initFlutter(); // Pastikan Hive diinisialisasi
    stringBox = await Hive.openBox<String>('strings'); // Buka Box sebelum digunakan

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Periksa apakah ada email yang tersimpan di Hive
      if (stringBox.containsKey('email')) {
        var email = stringBox.get('email');
        usernameController.text = email!;
        Get.offAll(() => HomeView());
      }

      // Periksa apakah ada password yang tersimpan di Hive
      if (stringBox.containsKey('password')) {
        var password = stringBox.get('password');
        passwordController.text = password!;
      }
    });
  }



  var isHiddenPassword = true.obs;
  var isHiddenConfirmPassword = true.obs;
  var isChecked = false.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void togglePasswordVisibility() {
    isHiddenPassword.value = !isHiddenPassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    isHiddenConfirmPassword.value = !isHiddenConfirmPassword.value;
  }

  void register() async {
    String name = nameController.text;
    String email = usernameController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (!EmailValidator.validate(email)) {
      showErrorMessage('Invalid email format.');
      return;
    }

    password = password.trim();
    confirmPassword = confirmPassword.trim();

    if (password != confirmPassword) {
      showErrorMessage('Password and confirmation password do not match.');
      return;
    }

    try {
      var registerUrl = Uri.parse('http://localhost:8000/api/register');
      var registerResponse = await http.post(
        registerUrl,
        body: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      if (registerResponse.statusCode == 201) {
        showSuccessMessage('User registered successfully');
      } else if (registerResponse.statusCode == 422) {
        var errorResponse = json.decode(registerResponse.body);
        var errorMessage = errorResponse['message'];
        showErrorMessage(errorMessage);
      } else {
        showErrorMessage('Failed to register user');
      }
    } catch (e) {
      showErrorMessage('An error occurred during registration');
    }
  }

  void login() async {
    String email = usernameController.text;
    String password = passwordController.text;

    // jika sandi kosong atau tidak valid
    if (password.isEmpty || !EmailValidator.validate(email)) {
      showErrorMessage('Invalid email or password.');
      return;
    }

    // jika username nana@mail.com dan sandinya 1 maka login berhasil dan ke Home
    if (email == 'nana@mail.com' && password == '1') {
      // set username
      stringBox.put('email', email);
      showSuccessMessage('Login berhasil');
      Get.offAll(() => Home());
      return;
    }

    try {
      var url = Uri.parse('http://localhost:8000/api/login');
      var response = await http.post(
        url,
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        showSuccessMessage('User logged in successfully');
        Get.offAll(() => Home());
      } else if (response.statusCode == 401) {
        showErrorMessage('Incorrect email or password.');
      } else {
        showErrorMessage('Failed to login');
      }
    } catch (e) {
      showErrorMessage('An error occurred during login');
    }
  }

  void showSuccessMessage(String message) {
    Get.snackbar('Success', message, snackPosition: SnackPosition.BOTTOM);
  }

  void showErrorMessage(String message) {
    Get.snackbar('Error', message, snackPosition: SnackPosition.BOTTOM);
  }
}
