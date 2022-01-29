// ignore_for_file: prefer_const_constructors

import 'package:delivery_saller/allpage/choosepage.dart';
import 'package:delivery_saller/allpage/glavniypagr.dart';
import 'package:delivery_saller/allpage/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
void main() async{

  await Hive.initFlutter();
  await Hive.openBox("MyBaza");

  runApp(MyApp());
} 


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home:  Choose()
    );
  }
}

