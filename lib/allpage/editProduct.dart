// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';

import 'package:delivery_saller/network/networkapi.dart';
import 'package:delivery_saller/network/networkparams.dart';
import 'package:delivery_saller/network/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({Key? key,required this.item}) : super(key: key);
   
   final dynamic item; 
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final titlecontroller = TextEditingController();
  final costcontroller = TextEditingController();
  final countcontroller = TextEditingController();

  final TextEditingController typeAheadController1 = TextEditingController();
  final TextEditingController typeAheadController2 = TextEditingController();
  final formkey1 = GlobalKey<FormState>();
  final formkey2 = GlobalKey<FormState>();
  static List<String> items1 = ["Kg", "Dona"];
  static List<String> items2 = ["Kg", "Dona", "Kg", "Dona"];

  String selectedCity = '';
  bool textbool1 = false;
  bool textbool2 = false;
  var categorylist;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getinit();
  }

  getinit() async {
    var res = await NetworkPosts.getApi(Api.category, Params.empty());
    categorylist = jsonDecode(res);
    items2.clear();
    for(int i=0;i<categorylist.length;i++){
      items2.add(categorylist[i]['title']);
    }
    titlecontroller.text=widget.item['title'];
    typeAheadController1.text=items1[widget.item['unit_id']-1].toString();
    typeAheadController2.text=items2[widget.item['category_id']].toString();
    costcontroller.text= widget.item['price'].toString();
    countcontroller.text = widget.item['quantity'].toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text(" Mahsulotni tahrirlash"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        alignment: AlignmentDirectional.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            TextField(
              controller: titlecontroller,
              decoration: InputDecoration(
                label: Text("Mahsulot nomini kiriting"),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey.shade800)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: formkey1,
              child: TypeAheadFormField(
                suggestionsCallback: (pattern) => items1.where((item) =>
                    item.toLowerCase().contains(pattern.toLowerCase())),
                itemBuilder: (_, String item) {
                  textbool1 = true;

                  return ListTile(title: Text(item));
                },
                onSuggestionSelected: (String val) {
                  typeAheadController1.text = val;
                },
                getImmediateSuggestions: true,
                hideSuggestionsOnKeyboardHide: false,
                hideOnEmpty: false,
                noItemsFoundBuilder: (context) {
                  textbool1 = false;

                  return Padding(
                    padding: EdgeInsets.all(8),
                    child: Text("No item found"),
                  );
                },
                textFieldConfiguration: TextFieldConfiguration(
                    controller: typeAheadController1,
                    onChanged: (value) {
                      if (!textbool1) {
                        typeAheadController1.text = "";
                        setState(() {});
                      }
                    },
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.format_list_numbered_outlined),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueGrey.shade800)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                        labelText: 'Birlik tanlang')),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: formkey2,
              child: TypeAheadFormField(
                suggestionsCallback: (pattern) => items2.where((item) =>
                    item.toLowerCase().contains(pattern.toLowerCase())),
                itemBuilder: (_, String item) {
                  textbool2 = true;

                  return ListTile(title: Text(item));
                },
                onSuggestionSelected: (String val) {
                  typeAheadController2.text = val;
                },
                getImmediateSuggestions: true,
                hideSuggestionsOnKeyboardHide: false,
                hideOnEmpty: false,
                noItemsFoundBuilder: (context) {
                  textbool2 = false;

                  return Padding(
                    padding: EdgeInsets.all(8),
                    child: Text("No item found"),
                  );
                },
                textFieldConfiguration: TextFieldConfiguration(
                    controller: typeAheadController2,
                    onChanged: (value) {
                      if (!textbool2) {
                        typeAheadController2.text = "";
                        setState(() {});
                      }
                    },
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.format_list_numbered_outlined),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueGrey.shade800)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                        labelText: 'Kategoriyani tanlang')),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: costcontroller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text("Mahsulot narxini kiriting"),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey.shade800)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: countcontroller,
               keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text("Mahsulot sonini kiriting"),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey.shade800)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              margin: EdgeInsets.all(0),
              color: Colors.green,
              child: InkWell(
                onTap: () async{
                  String title = titlecontroller.text.trim();
                  String type = typeAheadController1.text.trim();
                  String categoty = typeAheadController2.text.trim();
                  String cost = costcontroller.text.trim();
                  String count = countcontroller.text.trim();
                   int categoryId=0;
                   int typeId=0;
                  if (title.isEmpty ||
                      type.isEmpty ||
                      categoty.isEmpty ||
                      cost.isEmpty ||
                      count.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Malumotlarni to'ldiring",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {
                    
                    for(int i=0;i<categorylist.length;i++){
                      if(categorylist[i]['title']==categoty){
                         categoryId=categorylist[i]['id'];
                      }
                    }
                    if(type=='kg'){
                      typeId=1;
                    }else{
                      typeId=2;
                    }
                    var res = await NetworkPosts.putApi(Api.products, Params.sendProductParams(title, categoryId.toString(), typeId.toString(), cost, count),id: widget.item['id'].toString());
                    var message = jsonDecode(res);
                     Fluttertoast.showToast(
                        msg:message['message'],
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                  Navigator.pop(context);
                },
                splashColor: Colors.grey,
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.4,
                  alignment: Alignment.center,
                  child: Text(
                    "O'ZGARTRISH",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
