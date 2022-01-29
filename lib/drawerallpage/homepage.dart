// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:delivery_saller/network/networkapi.dart';
import 'package:delivery_saller/network/networkparams.dart';
import 'package:delivery_saller/network/services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool svitch = true;
  bool getRespons = false;
  var shopInfo;
  Color activecolor = Colors.green;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getapi();
  }

  getapi() async {
    var res = await NetworkPosts.getApi(Api.get_my_shop, Params.empty());
     shopInfo = jsonDecode(res);
    getRespons = true;
    svitch = shopInfo['status']==0?false:true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: getRespons?Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Container(
                padding: EdgeInsets.only(left: 20,right: 5),
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(15),
                  color: Colors.white,
                    // ignore: prefer_const_literals_to_create_immutables
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        spreadRadius: 3,
                        color: Colors.grey.shade300,
                      )
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(shopInfo['title'],style: TextStyle(color: Colors.blueGrey[600],fontSize: 17),),
                    Switch(
                        activeColor: Colors.green,
                        inactiveThumbColor: Colors.red,
                        inactiveTrackColor: Colors.red[300],
                        value: svitch,
                        onChanged: (value)async{
                          setState(() {
                            svitch = value;
                          });
                           var res = await NetworkPosts.putApi(Api.status_shops+"/"+shopInfo['id'].toString(), Params.empty());
                           var message = jsonDecode(res);
                          Fluttertoast.showToast(
                              msg: message['message'],
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 1,
                              backgroundColor:
                                  value ? Colors.green : Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        })
                  ],
                ),
              )
            ],
          ),
        ):Center(child: CircularProgressIndicator())
        );
  }
}
