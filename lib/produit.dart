import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class produit{
  static String baseUrl = "http://localhost:3001/";
  static Future<List> getAllProduit() async{
    try{
      var res = await http.get(Uri.parse(baseUrl+'/produits'));
      if(res.statusCode == 200){
        return jsonDecode(res.body);
      }
      else{
        return Future.error("erreur serveur");
      }
    }
    catch(err){
      return Future.error(err);
    }
  }

  static Login(BuildContext context, login, password) async{
     try{
      var connection = {"email": login, "password": password};
      var res = await http.post(
        Uri.parse("http://localhost:3001/users/login"),
        encoding: Utf8Codec(),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': "*/*",
        'connection': 'keep-alive',
        'Accept-Encoding' : 'gzip, deflate, br',
        },
        body: connection
      );
      if(res.statusCode == 200){
        Navigator.pushNamed(context, '/liste');
      }
      else{
        Navigator.pushNamed(context, '/');
      }
    }
    catch(err){
      return Future.error(err);
    }
   }
  static ajout(BuildContext context, title, body) async{
    try{
     
      Map<String,dynamic> data= {"title":title,"body":body};
      var res = await http.post(
        Uri.parse(baseUrl+'/posts'), 
        body: data
        );
      if(res.statusCode == 201){
        Navigator.pushNamed(context, '/liste', arguments: res.body

        );
      }
      else{
        Navigator.pushNamed(context, '/');
      }
    }
    catch(err){
      return Future.error(err);
    }
  }
}