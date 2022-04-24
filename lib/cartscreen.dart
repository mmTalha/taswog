import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taswag/checkout.dart';
import 'package:taswag/provider.dart';

class cart_screen extends StatefulWidget {
  final cartdetails;
  final discount;
  final order_total;
  final product_total;
  final delivery_charges;
  final discount_id;

  const cart_screen({
    Key key,
    this.cartdetails,
    this.delivery_charges,
    this.discount,
    this.discount_id,
    this.order_total,
    this.product_total,
  }) : super(key: key);

  @override
  _cart_screenState createState() => _cart_screenState();
}

class _cart_screenState extends State<cart_screen> {
  Future cartitem;

  Future getcart() async {
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
    List data = responseJson['data']['user_id'];

    var product = data;
    print(product);
    return product;
  }

  int index1;

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
              'cart',
              style: TextStyle(color: Colors.black),
            )),
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
                }),
            actions: [
              IconButton(
                  icon: Icon(Icons.shopping_cart),
                  color: Colors.black,
                  onPressed: () {
                    getcart();
                    // setState(() {
                    //   cartitem = getcart();
                    // });
                  }),
            ],
          ),
          // body: Center(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         Text( 'Add items to get started',style: TextStyle(color: Colors.purple,fontWeight: FontWeight.w500,fontSize: 20 ),),
          //         Icon(Icons.shopping_cart,size: 55,color: Colors.orange,)
          //       ],
          //   ),
          // ),
          body:
              // FutureBuilder(
              //     future: getcart() ,
              //     builder: (context, snapshot) {
              //       if (!snapshot.hasData) {
              //         return Center(
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children: [
              //               Text('Add items to get started', style: TextStyle(
              //                   color: Colors.purple,
              //                   fontWeight: FontWeight.w500,
              //                   fontSize: 20),),
              //               Icon(
              //                 Icons.shopping_cart, size: 55, color: Colors.orange,)
              //             ],
              //           ),
              //         );
              //       } else {
              //         print(' link${snapshot.data}   ');
              //       }
              //
              //       return

              Consumer<EligiblityScreenProvider>(
                  builder: (context, provider, child) {
               return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        child: Text(
                          'Your cart',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Text('  oil and ghee '),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(5)),
                            width: 60,
                            height: 20,
                            child: Center(
                                child: Text(
                              'item1 ',
                              style: TextStyle(color: Colors.white),
                            )),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.only(bottom: 10),
                              itemCount: widget.cartdetails.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  leading: Image.asset('assets/barkat.png'),
                                  title: Row(
                                    children: [
                                      Text(
                                          '${widget.cartdetails[index]['product_name']}'),
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
                                              '${widget.cartdetails[index]['product_name']}'),
                                          Row(
                                            children: [
                                              Container(
                                                height: 25,
                                                child: Center(
                                                  child: Icon(
                                                    Icons.delete,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 22,
                                              ),
                                              Text(
                                                '${index1}',
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Container(
                                                width: 25,
                                                height: 25,
                                                decoration: BoxDecoration(),
                                                child: Center(
                                                  child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        index1 = int.parse(
                                                            '${widget.cartdetails[index]['quantity']++}');
                                                        print(index1);
                                                      });
                                                    },
                                                    icon: Icon(Icons.add),
                                                    iconSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]),
                                  ),
                                );
                              }),
                          // Container(
                          //   color: Colors.purple,
                          //   child: Text('hello'),
                          // ),
                          SizedBox(
                            height: 100,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Subtotal'),
                                      Text(
                                          '  ${widget.cartdetails[index]['order_total']} '),
                                    ],
                                  ),
                                );
                              }),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Discount'),
                                        Text(
                                            '  ${widget.cartdetails[index]['discount_price']} '),
                                      ]),
                                );
                              }),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Delivery charges'),
                                      Text(
                                          '${widget.cartdetails[index]['delivery_charges']}'),
                                    ],
                                  ),
                                );
                              }),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(' order totaL'),
                                      Text(
                                          '${widget.cartdetails[index]['order_total']}'),
                                    ],
                                  ),
                                );
                              }),
                          SizedBox(
                            height: 60,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                height: 50,
                                width: 220,
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  color: Colors.orange,
                                  child: Text(
                                    'Secure checkout',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Geeza Pro'),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                            transitionDuration:
                                                Duration(seconds: 2),
                                            pageBuilder: (context, animation,
                                                    animationtime) =>
                                                Checkout_screen(),
                                            transitionsBuilder: (context,
                                                animation,
                                                animationtime,
                                                child) {
                                              animation = CurvedAnimation(
                                                  parent: animation,
                                                  curve: Curves.elasticInOut);
                                              return ScaleTransition(
                                                scale: animation,
                                                child: child,
                                                alignment: Alignment.center,
                                              );
                                            }));
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Container(
                                height: 50,
                                width: 220,
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
                                    provider.deletecart();
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ]),
            );
          }),
        );
      }),
    );
  }
}
