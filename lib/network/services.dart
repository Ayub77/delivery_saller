import 'dart:convert';

import 'package:delivery_saller/network/networkapi.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;

class NetworkPosts{
  static var box = Hive.box("MyBaza");


 static Future getApi(String api, Map<String, String> params) async {
    var uri = Uri.http(Api.Base, api, params);
    var res = await box.get('auth');
    String auth = res ?? "";
    Map<String, String> head = {
      'Coutent-Type': 'application/json; charset=UTF-8',
      'Authorization': auth
    };
    var response =    await http.get(uri, headers: head);

    if (response.statusCode < 299) {
      return response.body;
    }
    return null;
  }

 static Future getProduct(String api, Map<String, String> params) async {
    
    var uri = Uri.http(Api.Base, api, params);
    var res = await box.get('auth');
    String auth = res ?? "";
    Map<String, String> head = {
      'Coutent-Type': 'application/json; charset=UTF-8',
      'Authorization': auth
    };
    var response = await http.get(uri, headers: head);

    if (response.statusCode < 299) {
      return response.body;
    }
    return null;
  }

  static Future deleteApi(String api,String id, Map<String, String> params) async {
    
    var uri = Uri.http(Api.Base, api+"/"+id, params);
    var res = await box.get('auth');
    String auth = res ?? "";
    Map<String, String> head = {
      'Coutent-Type': 'application/json; charset=UTF-8',
      'Authorization': auth
    };
    var response = await http.delete(uri, headers: head);

    if (response.statusCode < 299) {
      return response.body;
    }
    return null;
  }
 

 static Future postApi(String api, Map<String, String> params) async {
    var uri = Uri.http(Api.Base, api);
    var res = box.get('auth');
     String auth = res ?? "";
    Map<String, String> head = {
      'Coutent-Type': 'application/json; charset=UTF-8',
      'Authorization': auth
    };
    var response = await http.post(uri, headers: head, body: params);

    if (response.statusCode < 299) {
      return response.body;
    }
    return null;
  }

  static Future putApi(String api, Map<String, String> params,{String? id}) async {
    var uri = Uri.http(Api.Base, api+"/"+id!);
    var res = box.get('auth');
     String auth = res ?? "";
    Map<String, String> head = {
      'Coutent-Type': 'application/json; charset=UTF-8',
      'Authorization': auth
    };
    var response = await http.put(uri, headers: head, body: params);

    if (response.statusCode < 299) {
      return response.body;
    }
    return null;
  } 

}