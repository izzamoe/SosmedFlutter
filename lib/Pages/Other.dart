import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Controllers/HomeControllers.dart';

class Other extends StatelessWidget {
  // You can ask Get to find a Controller that is being used by another page and redirect you to it.
  final Controller c = Get.find();

  @override
  Widget build(context){
     // Access the updated count variable
     return Scaffold(body: Center(child: Text("${c.count}")));
  }
}