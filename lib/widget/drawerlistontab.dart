
import 'package:delivery_saller/funcsion/funcsion.dart';
import 'package:flutter/material.dart';

class ListOntab extends StatelessWidget {
  ListOntab({Key? key, required this.name, required this.icon,required this.ontap})
      : super(key: key);
  String name;
  Icon icon;
  Function ontap;
  @override
  Widget build(BuildContext context) {
    int index = Funcsions.namevalueindex(name);
    return ListTile(
      onTap: () {
        ontap(index);
      },
      leading: icon,
      title: Text(name),
      iconColor: Colors.white,
      textColor: Colors.white,
    );
  }
}