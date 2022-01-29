// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'dart:convert';

import 'package:delivery_saller/allpage/glavniypagr.dart';
import 'package:delivery_saller/network/networkapi.dart';
import 'package:delivery_saller/network/networkparams.dart';
import 'package:delivery_saller/network/services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static var box = Hive.box("MyBaza");
  final logincontroller = TextEditingController();
  final parolcontroller = TextEditingController();
  bool chek = true;
  Color colors = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/login.jpg"),
                        fit: BoxFit.contain)),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: logincontroller,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.blue, width: 1)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey, width: 1)),
                  label: Text("Login"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: parolcontroller,
                obscureText: chek,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          if (chek) {
                            chek = false;
                            colors = Colors.blue;
                          } else {
                            chek = true;
                            colors = Colors.grey;
                          }
                        });
                      },
                      icon: Icon(
                        Icons.remove_red_eye_outlined,
                        color: colors,
                      )),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.blue, width: 1)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey, width: 1)),
                  label: Text("Parol"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                color: Colors.green,
                margin: EdgeInsets.all(0),
                child: InkWell(
                  onTap: () async{
                    String login = logincontroller.text.trim();
                    String parol = parolcontroller.text.trim();
                    if (login == "" || parol == "") {
                      Fluttertoast.showToast(
                          msg: "Malumotlaringizni kiriting",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else{
                      String basicAuth = "Basic " + base64Encode(utf8.encode('$login:$parol'));
                      box.put('auth', null);
                      box.put('auth', basicAuth);
                      var respons = await  NetworkPosts.getApi(Api.login, Params.empty());
                      if(respons!=null){
                       var res = await NetworkPosts.getApi(Api.user, Params.empty());
                       var data = jsonDecode(res);
                       bool chek =data['data']['rules']['saller'] ?? false;
                       if(chek){
                         box.put("user", res);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => Glavniy(id: 0)));
                       } else{
                         box.put("auth", null);
                         Fluttertoast.showToast(
                          msg: "Login yoki parol xato",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                       }
                      }else{
                        box.put("auth", null);
                         Fluttertoast.showToast(
                          msg: "Login yoki parol xato",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      }
                    }
                  },
                  splashColor: Colors.grey,
                  child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                      child: Text(
                        "KIRISH",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
