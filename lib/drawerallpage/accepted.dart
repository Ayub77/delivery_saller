// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Accepted extends StatefulWidget {
  const Accepted({ Key? key }) : super(key: key);

  @override
  _AcceptedState createState() => _AcceptedState();
}

class _AcceptedState extends State<Accepted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Accepted"),),
    );
  }
}