// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Canceled extends StatefulWidget {
  const Canceled({ Key? key }) : super(key: key);

  @override
  _CanceledState createState() => _CanceledState();
}

class _CanceledState extends State<Canceled> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(child: Text("Canceled"),)
    );
  }
}