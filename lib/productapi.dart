import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:taswag/productpage.dart';


 class productapi extends StatefulWidget {
   @override
   _productapiState createState() => _productapiState();
 }
 
 class _productapiState extends State<productapi> {
   @override


   Future   getproduct() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     var token = prefs.getString('data');
     print(token);
     var authorizations = await http.get(
       'http://grocery.taswog.com/api/get-all-products',
       headers: {

         "Authorization": "Bearer $token",
       },
     );
     var responseJson = await json.decode(authorizations.body);
     List data = responseJson['data'];
     var product = data ;
     return product;


   }

   void initState() {
     super.initState();
      getproduct();
   }






   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body:FutureBuilder(
         future: getproduct(),
       builder: (context, snapshot) {
         if (!snapshot.hasData) {
           return Center(child: CircularProgressIndicator());
         } else {
           print(' link${snapshot.data}   ');
         }

         return ListView.builder(
           scrollDirection: Axis.horizontal,
             padding: EdgeInsets.all(8),
             itemCount: snapshot.data.length,
             itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                   Text( '${snapshot.data[index]['product_id']} '),
                  Text( '${snapshot.data[index]['product_name']} '),
                  Text( '${snapshot.data[index]['product_image']} '),
                  Text( '${snapshot.data[index]['units']} '),
                  Text( '${snapshot.data[index]['Price']} '),
                  Text( '${snapshot.data[index]['Price']} '),
                  Text( '${snapshot.data[index]['description']} '),


                ],
          ),

               );


             }
         );
       }),
       );}
 }