// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, duplicate_ignore

import 'dart:convert';

import 'package:delivery_saller/allpage/addproductpage.dart';
import 'package:delivery_saller/allpage/editProduct.dart';
import 'package:delivery_saller/funcsion/funcsion.dart';
import 'package:delivery_saller/network/networkapi.dart';
import 'package:delivery_saller/network/networkparams.dart';
import 'package:delivery_saller/network/services.dart';
import 'package:delivery_saller/widget/productwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  bool chekswitch = true;
  bool get = false;
  final formkey = GlobalKey<FormState>();
  static List<String> items1 = ["Kg", "Dona", "Kg", "Dona"];
   final TextEditingController typeAheadController = TextEditingController();
    bool textbool = false;

  var items;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getproduct();
  }

  getproduct() async {
    var res1 = await NetworkPosts.getApi(Api.category, Params.empty());
    var categorylist = jsonDecode(res1);
    items1.clear();
    for(int i=0;i<categorylist.length;i++){
      items1.add(categorylist[i]['title']);
    }

   String category = typeAheadController.text.trim();   
     int categoryId=-1;
   for(int i=0;i<categorylist.length;i++){
     if(category==categorylist[i]['title']){
        categoryId=categorylist[i]['id'];
        break;
     }
   } 
   var res = await NetworkPosts.getProduct(
        Api.products, Params.productparams("1", "", categoryId!=-1?categoryId.toString():""));
    items = jsonDecode(res);
    get = true;
     
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: get
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Container(),
                        Text(
                          "Mahsulotlarim",
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Card(
                          margin: EdgeInsets.all(0),
                          color: Colors.blueGrey[600],
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (context) => AddProduct()))
                                  .then((value) {
                                getproduct();
                              });
                            },
                            splashColor: Colors.grey,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              alignment: Alignment.center,
                              child: Text(
                                "+",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 28),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 45,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Expanded(
                              child: Form(
              key: formkey,
              child: TypeAheadFormField(
                suggestionsCallback: (pattern) => items1.where((item) =>
                    item.toLowerCase().contains(pattern.toLowerCase())),
                itemBuilder: (_, String item) {
                  textbool = true;

                  return ListTile(title: Text(item));
                },
                onSuggestionSelected: (String val) {
                  typeAheadController.text = val;
                   getproduct();
                },
                getImmediateSuggestions: true,
                hideSuggestionsOnKeyboardHide: false,
                hideOnEmpty: false,
                noItemsFoundBuilder: (context) {
                  textbool = false;

                  return Padding(
                    padding: EdgeInsets.all(8),
                    child: Text("No item found"),
                  );
                },
                textFieldConfiguration: TextFieldConfiguration(
                    controller: typeAheadController,
                    onChanged: (value) {
                      if (!textbool) {
                        typeAheadController.text = "";
                      }
                    },
                    decoration: InputDecoration(
                       
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueGrey.shade800)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                        labelText: 'Kategoriyani tanlang')),
              ),
            ),),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: TextField(
                            decoration:
                                InputDecoration(border: OutlineInputBorder()),
                          )),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: items['data'].length,
                        itemBuilder: (context, index) {
                          return Productwidget(
                              item: items['data'][index],
                              editontap: (value) {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => EditProduct(
                                              item: items['data'][index],
                                            )))
                                    .then((value) {
                                  getproduct();
                                });
                              },
                              deleteontap: (value) {
                                showAnimatedDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return ClassicGeneralDialogWidget(
                                      titleText: items['data'][index]['title']
                                              .toString()
                                              .substring(0, 1)
                                              .toUpperCase() +
                                          items['data'][index]['title']
                                              .toString()
                                              .substring(
                                                  1,
                                                  items['data'][index]['title']
                                                      .toString()
                                                      .length) +
                                          " ni o'chirish",
                                      contentText:
                                          "Rostan ham o'chirmoqchimisiz?",
                                      negativeText: "Yo'q",
                                      positiveText: "Ha",
                                      onPositiveClick: () async {
                                        var res = await NetworkPosts.deleteApi(
                                            Api.products,
                                            value.toString(),
                                            Params.empty());
                                        var messeage = jsonDecode(res);
                                        Fluttertoast.showToast(
                                            msg: messeage['message'],
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.TOP,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                            getproduct();
                                        Navigator.of(context).pop();
                                      },
                                      onNegativeClick: () {
                                        Navigator.of(context).pop();
                                      },
                                    );
                                  },
                                  animationType: DialogTransitionType.scale,
                                  curve: Curves.fastOutSlowIn,
                                  duration: Duration(milliseconds: 1500),
                                );
                              },
                              switchonchange: (value)async{
                                  var res  = await NetworkPosts.putApi(Api.product, Params.empty(),id: value.toString());
                                  var message = jsonDecode(res);
                                  Fluttertoast.showToast(
                                            msg: message['message'],
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.TOP,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                            getproduct();
                              });
                        },
                      ),
                    )
                  ],
                ),
              )
            : Center(child: CircularProgressIndicator()));
  }
}
