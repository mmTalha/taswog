import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:taswag/all_productlist.dart';
import 'package:taswag/cartscreen.dart';
import 'package:taswag/emptycart.dart';
import 'package:taswag/horizontal_listview.dart';
import 'package:taswag/map.dart';
import 'package:taswag/productDetails.dart';
import 'package:taswag/productapi.dart';

class productpage extends StatefulWidget {
  @override
  _productpageState createState() => _productpageState();
}

class _productpageState extends State<productpage> {
  LatLng _center ;
  String token = "";
  List data;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Position _currentPosition;
  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString('token');
    });
  }

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

  Stream getOrdersStrem(Duration refreshTime) async* {
    while (true) {
      await Future.delayed(refreshTime);
      yield await getcartitem();
    }
  }

  List datalist;

  Future getproduct() async {
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
    List data = responseJson['data']['total info'];
    var product = data;
    print('godd$product ');
    return product;
  }

  Future getcart;

  // return responseJson. map((data) => new Photo.fromJson(responseJson)).toList();

  bool flag;

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getproduct(),
        builder: (context, snapshot) {
          print(snapshot.data);
          return Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                  backgroundColor: Colors.white,
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Delivering to  ',
                          style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                        Text(
                       '  ${ _center.toString()}',
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                        GestureDetector(
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      transitionDuration: Duration(seconds: 2),
                                      pageBuilder:
                                          (context, animation, animationtime) =>
                                              map(),
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

          // Future<Position> locateUser() async {
          // return Geolocator
          //     .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
          // }
          //
          // getUserLocation() async {
          // _currentPosition = await locateUser();
          // setState(() {
          //  _center = LatLng(_currentPosition.latitude, _currentPosition.longitude);
          // });
          // print('center $_center');
          // }
           }
          )
                      ]),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: StreamBuilder(
                          stream: getOrdersStrem(Duration(
                            seconds: 2,
                          )),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return IconButton(
                                  color: Colors.black,
                                  icon: Icon(CupertinoIcons.shopping_cart),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                            transitionDuration:
                                                Duration(seconds: 2),
                                            pageBuilder: (context, animation,
                                                    animationtime) =>
                                                emptycart(),
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
                                  });
                            } else {
                              // print(' link${snapshot.data}   ');

                              return IconButton(
                                  icon: Icon(
                                    CupertinoIcons.cart,
                                    size: 30,
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
                            }
                          }),
                    )
                  ]),
              body: SingleChildScrollView(
                child: Container(
                  child: Column(children: [
                    // Container(
                    //     margin: EdgeInsets.only(top: 50, left: 20),
                    //     child: Column(
                    //       children: [
                    //         Row(
                    //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //             children: [
                    //               Text(
                    //                 'delivering to',
                    //                 style: TextStyle(color: Colors.orange),
                    //               ),
                    //               Text('Gulshan karachi'),
                    //               IconButton(
                    //                   icon: Icon(Icons.add_location),
                    //                   onPressed: () {
                    //                     Navigator.push (
                    //                         context,
                    //                         PageRouteBuilder(
                    //                             transitionDuration:
                    //                                 Duration(seconds: 2),
                    //                             pageBuilder: (context, animation,
                    //                                     animationtime) =>
                    //                                 map(),
                    //                             transitionsBuilder: (context,
                    //                                 animation,
                    //                                 animationtime,
                    //                                 child) {
                    //                               animation = CurvedAnimation(
                    //                                   parent: animation,
                    //                                   curve: Curves.elasticInOut);
                    //                               return ScaleTransition(
                    //                                 scale: animation,
                    //                                 child: child,
                    //                                 alignment: Alignment.center,
                    //                               );
                    //                             }));
                    //                   }),
                    //               StreamBuilder(
                    //                   stream: getOrdersStrem(Duration(
                    //                     seconds: 2,
                    //                   )),
                    //                   builder: (context, snapshot) {
                    //                     if (!snapshot.hasData) {
                    //                       return IconButton(
                    //                           icon: Icon(  SimpleIcons.shopify ),
                    //                           onPressed: () {
                    //                             Navigator.push(
                    //                                 context,
                    //                                 PageRouteBuilder(
                    //                                     transitionDuration:
                    //                                         Duration(seconds: 2),
                    //                                     pageBuilder: (context,
                    //                                             animation,
                    //                                             animationtime) =>
                    //                                         emptycart(),
                    //                                     transitionsBuilder:
                    //                                         (context,
                    //                                             animation,
                    //                                             animationtime,
                    //                                             child) {
                    //                                       animation =
                    //                                           CurvedAnimation(
                    //                                               parent:
                    //                                                   animation,
                    //                                               curve: Curves
                    //                                                   .elasticInOut);
                    //                                       return ScaleTransition(
                    //                                         scale: animation,
                    //                                         child: child,
                    //                                         alignment:
                    //                                             Alignment.center,
                    //                                       );
                    //                                     }));
                    //                           });
                    //                     } else {
                    //                       // print(' link${snapshot.data}   ');
                    //                     }
                    //
                    //                     return IconButton(
                    //                         icon: Icon(
                    //                           Icons.shopping_cart,
                    //                         ),
                    //                         color: Colors.black,
                    //                         onPressed: () {
                    //                           getcartitem();
                    //                           Navigator.push(
                    //                               context,
                    //                               MaterialPageRoute(
                    //                                 builder: (
                    //                                   context,
                    //                                 ) =>
                    //                                     cart_screen(
                    //                                   cartdetails: snapshot.data,
                    //                                   //   cartdetails: snapshot
                    //                                   //       .data[0 ] ['order_total'],
                    //                                   //   delivery_charges: snapshot
                    //                                   //       .data[0]
                    //                                   //   ['delivery_charges'],
                    //                                   //   product_total:
                    //                                   //   snapshot
                    //                                   //       .data[0]
                    //                                   //   ['product_total'],
                    //                                   //   order_total:
                    //                                   //   snapshot
                    //                                   //       .data[0]
                    //                                   //   ['product_total'],
                    //                                   //   discount: snapshot
                    //                                   //       .data[0]
                    //                                   //   ['discount_id'],
                    //                                   // ),
                    //                                 ),
                    //                               ));
                    //                         });
                    //                   }),
                    //             ]),
                    //           Padding(
                    //           padding: const EdgeInsets.all(8.0),
                    //           child: TextField(
                    //             decoration: InputDecoration(
                    //               focusColor: Colors.grey,
                    //               icon: Icon(Icons.search),
                    //               hintText: 'search store',
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     )),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                CupertinoIcons.search,
                                color: Colors.grey,
                              ),
                              prefixStyle: TextStyle(color: Colors.grey),
                              hintText: 'Search your category',
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.red)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.red))),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/coverimage.png'),
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(left: 30, top: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Packages ',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Times New Roman',
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    //  newepage

                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 50,
                                      child: Image.asset('assets/rashan1.png'),
                                    ),

                                    Text('package2'),

                                    // Text('${snapshot.data['Price']}'),
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Text('pkr'),
                                            Text('300'),
                                          ],
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          width: 20,
                                          height: 40,
                                          margin: EdgeInsets.only(),
                                          child: Hero(
                                            tag: 'col',
                                            child: IconButton(
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
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                        height: 60,
                                        width: 50,
                                        child:
                                            Image.asset('assets/rashan1.png'),
                                      ),
                                    ),
                                    Text('package2'),

                                    // Text('${snapshot.data['Price']}'),
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Text('pkr'),
                                            Text('300'),
                                          ],
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          width: 20,
                                          height: 40,
                                          margin: EdgeInsets.only(),
                                          child: Hero(
                                            tag: 'col',
                                            child: IconButton(
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
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                        height: 60,
                                        width: 50,
                                        child:
                                            Image.asset('assets/rashan1.png'),
                                      ),
                                    ),
                                    Text('package2'),

                                    // Text('${snapshot.data['Price']}'),
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Text('pkr'),
                                            Text('300'),
                                          ],
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          width: 20,
                                          height: 40,
                                          margin: EdgeInsets.only(),
                                          child: Hero(
                                            tag: 'col',
                                            child: IconButton(
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
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                        height: 60,
                                        width: 50,
                                        child:
                                            Image.asset('assets/rashan1.png'),
                                      ),
                                    ),
                                    Text('package2'),

                                    // Text('${snapshot.data['Price']}'),
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Text('pkr'),
                                            Text('300'),
                                          ],
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          width: 20,
                                          height: 40,
                                          margin: EdgeInsets.only(),
                                          child: Hero(
                                            tag: 'col',
                                            child: IconButton(
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
                                    )
                                  ],
                                ),
                                // Card('Package2', 'pkr', '300 ', 'assets/rashan1.png'),
                                // Card('package2', 'PKR', '300', 'assets/rashan1.png'),
                                // Card('package2', 'PKR', '300', 'assets/rashan1.png'),
                                // Card('package2', 'PKR', '300', 'assets/rashan1.png'),
                                // Card('package2', 'PKR', '300', 'assets/rashan1.png'),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 30, top: 30),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Top Products     ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Times New Roman',
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          horizontal_list(),
                          SizedBox(
                            height: 35,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // Card(
                                //     '${snapshot.data['product_name']}',
                                //     'pkr',
                                //     '${snapshot.data['product_name']} ',
                                //     'assets/Ariel .png'),
                                real('assets/Ariel .png', 'Ariel', '300'),
                                real('assets/Ariel .png', 'Ariel', '300'),
                                real('assets/Ariel .png', 'Ariel', '300'),
                                real('assets/Ariel .png', 'Ariel', '300'),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 40,
                                ),
                                child: Text(
                                  'Groceries',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                ),
                              ),
                              FlatButton(
                                  onPressed: null,
                                  child: Text(
                                    'see all',
                                    style: TextStyle(color: Colors.grey),
                                  ))
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 50,
                                width: 120,
                                color: Colors.orangeAccent,
                                child: Row(
                                  children: [
                                    Image.asset('assets/pulses.png'),
                                    Text(
                                      'Pulses',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'sans-serif'),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 120,
                                color: Color.fromRGBO(83, 177, 117, 1),
                                child: Row(
                                  children: [
                                    Image.asset('assets/grocery.png'),
                                    Text(
                                      'Rice',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'sans-serif'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // Card(
                                //     '${snapshot.data['product_name']}',
                                //     'pkr',
                                //     '${snapshot.data['product_name']} ',
                                //     'assets/Ariel .png'),
                                // Card('Dalda Cooking oil', 'pkr', '300 ',
                                //     'assets/Dalda .png'),
                                // Card(
                                //     'Everyday', 'pkr', '300 ', 'assets/everyday.png'),
                                // Card(
                                //     'Surf Excel', 'pkr', '300 ', 'assets/Ariel .png'),
                                // Card('Dalda Cooking oil', 'pkr', '300 ',
                                //     'assets/Dalda .png'),
                                // Card(
                                //     'Everyday', 'pkr', '300 ', 'assets/everyday.png'),
                                // Card('Package2', 'pkr', '300 ', 'assets/rashan1.png'),
                                real('assets/Ariel .png', 'Ariel', '300'),
                                real('assets/Ariel .png', 'Ariel', '300'),
                                real('assets/Ariel .png', 'Ariel', '300'),
                                real('assets/Ariel .png', 'Ariel', '300'),
                              ],
                            ),
                          ),
                          // all_products()
                        ])
                  ]),
                ),
              ));
        });
  }
}

Widget _buildCard(
  String name,
  String price,
  String imgPath,
  String package,
) {
  return InkWell(
      onTap: () {},
      child: Container(
          height: 180,
          width: 110,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3.0,
                    blurRadius: 5.0)
              ],
              color: Colors.white),
          child: Column(children: [
            Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end, children: [])),
            Container(
                height: 75.0,
                width: 75.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(imgPath), fit: BoxFit.cover))),
            SizedBox(height: 7.0),
            Text(price,
                style: TextStyle(
                    color: Color(0xFFCC8053),
                    fontFamily: 'Varela',
                    fontSize: 14.0)),
            Text(name,
                style: TextStyle(
                    color: Color(0xFF575E67),
                    fontFamily: 'Varela',
                    fontSize: 14.0)),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(color: Color(0xFFEBEBEB), height: 1.0)),
            Padding(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.add, color: Color(0xFFD17E50), size: 12.0),
                    Text(package,
                        style: TextStyle(
                            fontFamily: 'Varela',
                            color: Color(0xFFD17E50),
                            fontSize: 12.0))
                  ],
                ))
          ])));
}

Widget Card(
  String package,
  String pkr,
  String rps,
  String img,
) {
  return Column(
    children: [
      Container(
          height: 60,
          width: 100,
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

//  neewpage
//         ],
//       ),
//     ),
//   ) ,

//     );
//   }
// }
Widget real(
  String img,
  String package,
  String price,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Center(
        child: Container(
          height: 60,
          width: 50,
          child: Image.asset(img),
        ),
      ),
      Text(package),

      // Text('${snapshot.data['Price']}'),
      Row(
        children: [
          Column(
            children: [
              Text('pkr'),
              Text(price),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            width: 20,
            height: 40,
            margin: EdgeInsets.only(),
            child: Hero(
              tag: 'col',
              child: IconButton(
                  color: Colors.orange,
                  iconSize: 30,
                  icon: Icon(Icons.add_box),
                  onPressed: () {}),
            ),
          ),
        ],
      )
    ],
  );
}
