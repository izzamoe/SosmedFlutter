import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Controllers/LoginControllers.dart';
import 'package:myapp/shared/theme_shared.dart';

import 'package:myapp/Controllers/welcome_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Welcomepage extends StatefulWidget {
  const Welcomepage({Key? key}) : super(key: key);

  @override
  _WelcomepageState createState() => _WelcomepageState();
}

class _WelcomepageState extends State<Welcomepage> {
  final WelcomeController controller = Get.put(WelcomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          children: [
            SizedBox(height: 60),
            Center(
              child: Transform.scale(
                scale: 1.3,
                child: Image.asset(
                  'assets/images/login-images.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 55),
            Text(
              "Welcome",
              style: blackTextStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "Website Sociablesphere dimana \nanda dapat terhubung dengan \nteman-teman lama, menjelajahi \nminat bersama, & menciptakan \nmomen-momen berharga dalam \nhidup Anda.",
              style: blackTextStyle.copyWith(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            buildButton(context, 'Create Account', _showRegisterBottomSheet),
            SizedBox(height: 15),
            buildButton(context, 'Login', _showLoginBottomSheet),
            SizedBox(height: 30),
            Text(
              'All Right Reserved @2024',
              textAlign: TextAlign.center,
              style: secondaryTextStyle.copyWith(color: secondaryColor, fontSize: 11),
            ),
            SizedBox(height: defaultMargin),
          ],
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context, String text, Function() onPressed) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width - 2 * defaultMargin,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: primaryTextStyle.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: primaryColor,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: secondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  void _showRegisterBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Wrap(
              children: [
                Container(
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 25),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hello...",
                                    style: blackTextStyle.copyWith(
                                      fontSize: 20,
                                      color: blackColor,
                                    ),
                                  ),
                                  Text(
                                    "Register",
                                    style: blackTextStyle.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: blackColor,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Image.asset(
                                    'assets/images/Close.png',
                                    height: 30,
                                    width: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: controller.nameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: "Name",
                              labelText: "Name",
                            ),
                          ),
                          SizedBox(height: 25),
                          TextField(
                            controller: controller.usernameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: "info@example.com",
                              labelText: "Username/Email",
                            ),
                          ),
                          SizedBox(height: 20),
                          Obx(() => TextField(
                            controller: controller.passwordController,
                            obscureText: controller.isHiddenPassword.value,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: "password",
                              labelText: "password",
                              suffixIcon: InkWell(
                                onTap: controller.togglePasswordVisibility,
                                child: Icon(
                                  controller.isHiddenPassword.value ? Icons.lock_open_outlined : Icons.lock_outline,
                                ),
                              ),
                            ),
                          )),
                          SizedBox(height: 20),
                          Obx(() => TextField(
                            controller: controller.confirmPasswordController,
                            obscureText: controller.isHiddenConfirmPassword.value,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: "confirm password",
                              labelText: "confirm password",
                              suffixIcon: InkWell(
                                onTap: controller.toggleConfirmPasswordVisibility,
                                child: Icon(
                                  controller.isHiddenConfirmPassword.value ? Icons.lock_open_outlined : Icons.lock_outline,
                                ),
                              ),
                            ),
                          )),
                          SizedBox(height: 20),
                          Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width - 2 * defaultMargin,
                            child: ElevatedButton(
                              onPressed: controller.register,
                              child: Text(
                                'Register',
                                style: primaryTextStyle.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: secondaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Already have account?",
                                style: primaryTextStyle.copyWith(
                                  color: blackColor,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "Login",
                                style: primaryTextStyle.copyWith(
                                  color: dangerColor,
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: defaultMargin),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showLoginBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Wrap(
              children: [
                Container(
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 25),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Welcome Back!!!",
                                    style: blackTextStyle.copyWith(
                                      fontSize: 20,
                                      color: blackColor,
                                    ),
                                  ),
                                  Text(
                                    "Login",
                                    style: blackTextStyle.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: blackColor,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Image.asset(
                                    'assets/images/Close.png',
                                    height: 30,
                                    width: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 25),
                          TextField(
                            controller: controller.usernameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: "info@example.com",
                              labelText: "Username/Email",
                            ),
                          ),
                          SizedBox(height: 20),
                          Obx(() => TextField(
                            controller: controller.passwordController,
                            obscureText: controller.isHiddenPassword.value,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: "password",
                              labelText: "password",
                              suffixIcon: InkWell(
                                onTap: controller.togglePasswordVisibility,
                                child: Icon(
                                  controller.isHiddenPassword.value ? Icons.lock_open_outlined : Icons.lock_outline,
                                ),
                              ),
                            ),
                          )),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Color(0xFFD7D7D7),
                                  border: Border.all(color: primaryColor, width: 3),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Obx(() => Checkbox(
                                  value: controller.isChecked.value,
                                  checkColor: Color(0xFFD7D7D7),
                                  onChanged: (value) {
                                    controller.isChecked.value = value!;
                                  },
                                )),
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Remember me",
                                style: blackTextStyle.copyWith(color: blackColor, fontSize: 12),
                              ),
                              Spacer(),
                              Text(
                                "Forgot Password?",
                                style: blackTextStyle.copyWith(color: blackColor, fontSize: 12),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width - 2 * defaultMargin,
                            child: ElevatedButton(
                              onPressed: controller.login,
                              child: Text(
                                'Login',
                                style: primaryTextStyle.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: secondaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Don’t have an account?",
                                style: primaryTextStyle.copyWith(
                                  color: blackColor,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "Register",
                                style: primaryTextStyle.copyWith(
                                  color: dangerColor,
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: defaultMargin),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
