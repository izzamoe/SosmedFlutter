import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/Pages/LoginPages.dart';
import 'package:myapp/shared/theme_shared.dart';
import 'Pages/HomePages.dart';

void main() 
  async{
  await Hive.initFlutter();
  await Hive.openBox<String>('strings');
  runApp(GetMaterialApp(
      home: Welcomepage(),
            theme: ThemeData(
        primarySwatch: ColorPalette.blackColor,
        primaryColor: primaryColor,
        canvasColor: Colors.transparent,
      ),
    ));
}