import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taswag/cartscreen.dart';
import 'package:taswag/emptycart.dart';

import 'provider.dart';

class whichlist extends StatefulWidget {
  @override
  _whichlistState createState() => _whichlistState();
}

class _whichlistState extends State<whichlist> {
  Future getcartitem() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('data');
    print(token);
    var authorizations = await http.get(
      'http://grocery.taswog.com/api/get-cartItems',
      headers: {
        'Accept': 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    var responseJson = await json.decode(authorizations.body);
    List data = responseJson['data'];
    var product = data;

    return product;
  }

  Stream getOrdersStrem(Duration refreshTime) async* {
    while (true) {
      await Future.delayed(refreshTime);
      yield await getcartitem();
    }
  }

  Future deletewishlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('data');
    print(token);
    var authorizations = await http.get(
      'http://grocery.taswog.com/api/delete-wishList',
      headers: {
        'Accept': 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    var responseJson = await json.decode(authorizations.body);
    List data = responseJson['data'];

    var product = data;
    print(product);
    return product;
  }

  Future getwishlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('data');
    print(token);
    var authorizations = await http.get(
      'http://grocery.taswog.com/api/get-wishListItems',
      headers: {
        'Accept': 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    var responseJson = await json.decode(authorizations.body);
    List data = responseJson['data'];

    var product = data;
    print(product);
    return product;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EligiblityScreenProvider>(
        create: (context) => EligiblityScreenProvider(),
        child: Builder(builder: (context) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Center(
                    child: Text(
                  'Wishlist',
                  style: TextStyle(color: Colors.black),
                )),
                leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.black,
                    onPressed: null),
                actions: [
                  StreamBuilder(
                      stream: getOrdersStrem(Duration(
                        seconds: 2,
                      )),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return IconButton(
                              icon: Icon(Icons.add_shopping_cart),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        transitionDuration:
                                            Duration(seconds: 2),
                                        pageBuilder: (context, animation,
                                                animationtime) =>
                                            emptycart(),
                                        transitionsBuilder: (context, animation,
                                            animationtime, child) {
                                          animation = CurvedAnimation(
                                              parent: animation,
                                              curve: Curves.elasticInOut);
                                          return ScaleTransition(
                                            scale: animation,
                                            child: child,
                                            alignment: Alignment.center,
                                          );
                                        }));
                              });
                        } else {
                          // print(' link${snapshot.data}   ');
                        }

                        return IconButton(
                            icon: Icon(
                              Icons.shopping_cart,
                            ),
                            color: Colors.black,
                            onPressed: () {
                              getcartitem();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (
                                      context,
                                    ) =>
                                        cart_screen(
                                      cartdetails: snapshot.data,
                                      //   cartdetails: snapshot
                                      //       .data[0 ] ['order_total'],
                                      //   delivery_charges: snapshot
                                      //       .data[0]
                                      //   ['delivery_charges'],
                                      //   product_total:
                                      //   snapshot
                                      //       .data[0]
                                      //   ['product_total'],
                                      //   order_total:
                                      //   snapshot
                                      //       .data[0]
                                      //   ['product_total'],
                                      //   discount: snapshot
                                      //       .data[0]
                                      //   ['discount_id'],
                                      // ),
                                    ),
                                  ));
                            });
                      }),
                ],
              ),
              body: Consumer<EligiblityScreenProvider>(
                builder: (context, provider, child) {
                  return FutureBuilder(
                      future: getwishlist(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                              child: CircularProgressIndicator(
                            backgroundColor: Colors.orange,
                          ));
                        } else {
                          print(' link${snapshot.data}   ');
                        }
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            padding: EdgeInsets.all(8),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      child: Column(children: [
                                        ListTile(
                                          leading:
                                              Image.asset('assets/barkat.png'),
                                          title: Row(
                                            children: [
                                              Text(
                                                  '${snapshot.data[index]['product_name']}'),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text('5kg'),
                                            ],
                                          ),
                                          trailing: Icon(Icons.plus_one),
                                          subtitle: Container(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      '${snapshot.data[index]['product_name']}'),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        height: 25,
                                                        child: Center(
                                                          child: IconButton(
                                                             icon: Icon(Icons.delete),
                                                            iconSize: 20,
                                                            onPressed: (){
                                                               provider.wishlistitemdelt(40);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 22,
                                                      ),
                                                      Text(
                                                        '1',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Container(
                                                        width: 25,
                                                        height: 25,
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: Center(
                                                          child: IconButton(
                                                            onPressed: () {
                                                              provider.deletewishlist();
                                                            },
                                                            icon:
                                                                Icon(Icons.add),
                                                            iconSize: 20,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      ]),
                                    ),
                                    Center(
                                      child: Container(
                                        margin: EdgeInsets.only(top: 420),
                                        height: 50,
                                        width:150,
                                        child: MaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15)),
                                          color: Colors.orange,
                                          child: Text(
                                            'clear cart',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Geeza Pro'),
                                          ),
                                          onPressed: () {
                                             provider.deletewishlist();

                                          },
                                        ),
                                      ),
                                    ),
                                  ]);
                            });
                      });
                },
              )
          );
        }
        )
    );
  }
}
