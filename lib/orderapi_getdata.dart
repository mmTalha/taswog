import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart ' as http;
import 'package:taswag/ordermodel.dart';
import 'package:taswag/ordermodel.dart';
import 'package:taswag/ordermodel.dart';
import 'package:taswag/ordersoverview.dart';
import 'package:taswag/productoverview.dart';

class orderapi extends StatefulWidget {
  @override
  _orderapiState createState() => _orderapiState();
}

class _orderapiState extends State<orderapi> {
  Future getordersdetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('data');
    print(token);
    var authorizations = await http.get(
      'http://grocery.taswog.com/api/get-my-orders',
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    var responseJson = await json.decode(authorizations.body);

    List data = responseJson['data'];
    var product = data;
    print('godd$product ');
    return product;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.keyboard_backspace),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          IconButton(
              iconSize: 20,
              color: Colors.black,
              icon: Icon(Icons.shopping_cart),
              onPressed: () async {}),
        ],
        title: Center(
            child: Text('My orders',
                style: TextStyle(
                    color: Colors.black, fontFamily: 'sans-serif-condensed'))),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: getordersdetails(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.all(8),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('order#  '),
                                  Text('${snapshot.data[index]['order_num']} '),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('product'),
                                      Container(
                                        height: 30,
                                        width: 80,
                                        child: MaterialButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            color: Colors.orange,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [


                                                  Text(
                                                    'View',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily:
                                                            'Geeza Pro'),
                                                  ),
                                                ]),
                                            onPressed: () async {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                  builder: (context) => orderOverview(orderid: snapshot.data[index]['order_id'], ordernum: snapshot.data[index]['order_num'], ),
                                              )); }),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              // ListTile(
                              //
                              //   leading:Column(
                              //        children: [
                              //          Text( 'leading'),
                              //          Text( 'prductname')
                              //        ],
                              //   ),
                              //   trailing: Text( 'trailing'),
                              //
                              // )
                            ],
                          ));
                    });
              }
            }),
      ),
    );
  }
}
