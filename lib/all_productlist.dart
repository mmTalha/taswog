import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:taswag/image_module.dart';


class all_products extends StatefulWidget {
  _all_productsState createState() => _all_productsState();
}

class _all_productsState extends State<all_products> {

  @override
  Future   allproducs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('data');
    print(token);

    var authorizations = await http.get(
      'http://grocery.taswog.com/api/get-all-products',
      headers: {
        "Authorization": "Bearer $token",
        'Content-Type': 'application/json'
      },
    );
    var responseJson = await json.decode(authorizations.body);
    List data = responseJson['data'];
    var product = data;
    return product;

  }

  void initState() {
    super.initState();
    allproducs();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100.0,
        child: FutureBuilder (
            future: allproducs(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                print(' link${snapshot.data}   ');
              }
              return

                     ListView.builder(
                        shrinkWrap: false,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.all(8),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                         return Card(  '${snapshot.data[index]['product_name']} '  ,
                             '${snapshot.data[index]['product_name']} ' ,
                             '${snapshot.data[index]['product_name']} ' ,
                             'assets/grocery.png');
                        }
                  );


            }));
  }
}
Widget Card(
    String package,
    String pkr,
    String rps,
    String img,
    ) {
  return   Column(
      children: [
          Container(
             height: 60,
              width:100,
              child: Image.asset(
                img,
              )),

        Text(package),
        SizedBox(
          height: 10,
        ),
        Text(pkr),
        Text(rps),
        Container(
          height: 35,
          margin: EdgeInsets.only(
            left: 70,
          ),
          child: IconButton(
              color: Colors.orange,
              iconSize: 30,
              icon: Icon(Icons.add_box),
              onPressed: () {}),
        ),
      ],

  );
}