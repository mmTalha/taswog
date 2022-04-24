


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taswag/cartscreen.dart';
import 'package:taswag/emptycart.dart';
import 'package:taswag/productDetails.dart';
import 'package:http/http.dart ' as http;


class sub_category extends StatefulWidget {
  @override
  _sub_categoryState createState() => _sub_categoryState();
}

class _sub_categoryState extends State<sub_category> {
  @override
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
  Stream  getOrdersStrem(Duration refreshTime) async* {
    while (true) {
      await Future.delayed(refreshTime);
      yield await getcartitem();
    }}

  @override
  Widget build(BuildContext context) {
  return  Scaffold(
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
        StreamBuilder(
            stream:   getOrdersStrem(
                Duration(
                  seconds: 2,
                )) ,
            builder: (context, snapshot) {
              if(!snapshot.hasData) {
                return  IconButton (icon:  Icon(Icons.add_shopping_cart), onPressed:  (){
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration:
                          Duration(seconds: 2),
                          pageBuilder: (context, animation,
                              animationtime) =>
                              emptycart(),
                          transitionsBuilder: (context,
                              animation, animationtime, child) {
                            animation = CurvedAnimation(
                                parent: animation,
                                curve: Curves.elasticInOut);
                            return ScaleTransition(
                              scale: animation,
                              child: child,
                              alignment: Alignment.center,
                            );
                          }));
                }) ;
              } else {
                // print(' link${snapshot.data}   ');
              }






              return

                IconButton(

                    icon: Icon(Icons.shopping_cart,),
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

            }),],








      title: Center(
          child: Text('Barkat',
              style: TextStyle(
                  color: Colors.black, fontFamily: 'sans-serif-condensed'))),
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(

          child: GridView.builder(

              shrinkWrap: true,
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                crossAxisCount: 2,
                childAspectRatio:3 /5,
                crossAxisSpacing:70,
                mainAxisSpacing: 30,
            ),
            itemBuilder: (context, index) {
            return   Container(
             width: 200,
              decoration: BoxDecoration(

                  border: Border.all(color: Colors.grey)
              ),

                child:   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset( 'assets/barkat.png'),
                      SizedBox(height: 5,),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text( 'Product name'),
                      ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Text( ' 1 kg  '),
                             SizedBox(width: 15,),
                             Text( 'price'),
                           ],
                        ),
                      SizedBox(height: 10,),
                        Container(

                          child: ListTile(
                            leading:  Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(('Pkr')),
                                Text('300'),
                              ],
                            ),

                            trailing: IconButton(
                                color: Colors.orange,
                                iconSize: 30,
                                icon: Icon(Icons.add_box),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            productdetails(),
                                      ));
                                }),


                          ),
                        ),

                    ],
                  ),


            );
          }
            ),
        ),
      ),
    ),
  );}}
