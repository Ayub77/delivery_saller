// ignore_for_file: prefer_const_constructors

import 'package:delivery_saller/allpage/glavniypagr.dart';
import 'package:delivery_saller/allpage/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Choose extends StatefulWidget {
  const Choose({Key? key}) : super(key: key);

  @override
  _ChooseState createState() => _ChooseState();
}

class _ChooseState extends State<Choose> {
  var box = Hive.box('MyBaza');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    choose();
  }

  choose() async {
    var res = await box.get("auth");
    await Future.delayed(const Duration(milliseconds: 400));
    if (res == null) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Glavniy(id: 0)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blueGrey[600],
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.only(bottom: 20),
        child: Text(
          "Saller",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
