// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace
import 'package:delivery_saller/allpage/glavniypagr.dart';
import 'package:delivery_saller/allpage/loginpage.dart';
import 'package:delivery_saller/widget/drawerlistontab.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class Drawerwidget extends StatelessWidget {
  const Drawerwidget({
    Key? key,required this.size,required this.name}) : super(key: key);

  final Size size;
  final String name;

  @override
  Widget build(BuildContext context) {
   var box = Hive.box("MyBaza");
    return Container(
      width: size.width * 0.7,
      child: Column(
        children: [
          Expanded(
              flex: 3,
              child: Container(
                color: Colors.blueGrey[600],
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    CircleAvatar(
                      backgroundColor: Colors.white38,
                      radius: size.width * 0.15,
                      child: CircleAvatar(
                        radius: size.width * 0.145,
                        backgroundColor: Colors.blueGrey[600],
                        child: CircleAvatar(
                          radius: size.width * 0.131,
                          backgroundColor: Colors.blueGrey[800],
                          child: Text(
                            name.substring(0,1).toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: size.width * 0.1),
                          ),
                        ),
                      ),
                    ),
                    Text(name.substring(0,1).toUpperCase()+name.substring(1,name.length),style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              )),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.black,
          ),
          Expanded(
              flex: 7,
              child: Container(
                color: Colors.blueGrey[600],
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        ListOntab(
                          name: "Boshsahifa",
                          icon: Icon(Icons.home),
                          ontap: (index) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Glavniy(id: index)));
                          },
                        ),
                        ListOntab(
                          name: "Mahsulotlar",
                          icon: Icon(Icons.list_alt),
                          ontap: (index) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Glavniy(id: index)));
                          },
                        ),
                        ListOntab(
                          name: "Yangi buyurtmalar",
                          icon: Icon(Icons.list_alt),
                          ontap: (index) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Glavniy(id: index)));
                          },
                        ),
                        ListOntab(
                          name: "Qabul qilingan",
                          icon: Icon(Icons.list_alt),
                          ontap: (index) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Glavniy(id: index)));
                          },
                        ),
                        ListOntab(
                          name: "Bajarilgan buyurtmalar",
                          icon: Icon(Icons.list_alt),
                         ontap: (index) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Glavniy(id: index)));
                          },
                        ),
                        ListOntab(
                          name: "Bekor qilingan",
                          icon: Icon(Icons.list_alt),
                         ontap: (index) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Glavniy(id: index)));
                          },
                        ),
                        ListOntab(
                          name: "Profil",
                          icon: Icon(Icons.person_outline_outlined),
                         ontap: (index) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Glavniy(id: index)));
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.black,
                        ),
                        ListTile(
                          title: Text("Chiqish",),
                          leading:Icon(Icons.logout),
                          iconColor: Colors.white,
                          textColor: Colors.white,
                          onTap: () {
                            box.put("user", null);
                            box.put("auth", null);
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => Login()));
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
