// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:delivery_saller/drawerallpage/%20fulfilledorders.dart';
import 'package:delivery_saller/drawerallpage/accepted.dart';
import 'package:delivery_saller/drawerallpage/canceled.dart';
import 'package:delivery_saller/drawerallpage/homepage.dart';
import 'package:delivery_saller/drawerallpage/neworders.dart';
import 'package:delivery_saller/drawerallpage/products.dart';
import 'package:delivery_saller/drawerallpage/profile.dart';
import 'package:delivery_saller/widget/drawerwidget.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class Glavniy extends StatefulWidget {
  const Glavniy({Key? key, required this.id}) : super(key: key);
  final int id;
  @override
  _GlavniyState createState() => _GlavniyState();
}

class _GlavniyState extends State<Glavniy> {
  static var box = Hive.box("MyBaza");
  bool chek = false;
  var user;
  List<Widget> windows = [
    HomePage(),
    Products(),
    Neworders(),
    Accepted(),
    Fulfieldorders(),
    Canceled(),
    Profile()
  ];
  Future<bool?> showwindow(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(
              "Dasturdan chiqish",
              style: TextStyle(color: Colors.black),
            ),
            content: Text("Rostdan ham chiqmoqchimisiz?",
                style: TextStyle(fontSize: 15, color: Colors.grey)),
            actions: [
              FlatButton(
                child: Text("Yo'q", style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              FlatButton(
                child: Text("Ha", style: TextStyle(color: Colors.green)),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ],
          ));
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getbaza();
  }

  getbaza() async {
    var data = await box.get("user");
     user = jsonDecode(data);
    chek = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        if (widget.id != 0) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Glavniy(id: 0)));
          return false;
        }
        final result = await showwindow(context);
        return result ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[600],
          actions: [
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.auto_stories_outlined),
                ),
                Transform.translate(
                  offset: Offset(-18, -10),
                  child: Container(
                    height: 16,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Center(
                        child: Text(
                      "92",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    )),
                  ),
                )
              ],
            ),
          ],
        ),
        body: windows[widget.id],
        drawer: chek?Drawerwidget(
          size: size,
          name: user['data']['username'],
        ):Container(),
      ),
    );
  }
}
