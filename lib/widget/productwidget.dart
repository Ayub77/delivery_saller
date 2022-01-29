// ignore_for_file: prefer_const_constructors

import 'package:delivery_saller/funcsion/funcsion.dart';
import 'package:flutter/material.dart';

class Productwidget extends StatelessWidget {
  const Productwidget({ Key? key,required this.item,required this.editontap, required this.deleteontap,required this.switchonchange }) : super(key: key);
   final dynamic item;
   final Function editontap;
   final Function deleteontap;
   final Function switchonchange;
  @override
  Widget build(BuildContext context) {
    return Container(
                margin: EdgeInsets.symmetric(vertical: 3),
                height: 55,
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(11),
                    // ignore: prefer_const_literals_to_create_immutables
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 5,
                          spreadRadius: 2)
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 90,
                      child: Text(item['title'],
                      style: TextStyle(color: Colors.blueGrey[800]))),
                    SizedBox(
                      width: 90,
                      child: Text(Funcsions.toProcessCost(item['price'].toString()) + " so'm",style: TextStyle(color: Colors.blueGrey[800]),)),
                    Row(
                      children: [
                        InkWell(
                          onTap: (){
                            editontap(item['id']);
                          },
                          child: Icon(Icons.edit,size: 20,color: Colors.green,),
                        ),
                        SizedBox(width: 11,),
                        InkWell(
                          onTap: (){
                            deleteontap(item['id']);
                          },
                          child: Icon(Icons.delete,size: 20,color: Colors.red,),
                        ),
                        SizedBox(width: 13,),
                        SizedBox(
                          width: 25,
                          child: Transform.scale(
                            scale: 0.8,        
                            child:Switch(  
                              activeColor: Colors.green,
                              inactiveThumbColor: Colors.red,
                              inactiveTrackColor: Colors.red[300],
                              value: item['active']==1?true:false,
                              onChanged: (value) {
                              switchonchange(item['id']);
                              }) ,
                          ),
                        )
                        
                      ],
                    )
                  ],
                ),
              );
  }
}