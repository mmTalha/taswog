import 'dart:convert';
 import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taswag/cartscreen.dart';
import 'package:taswag/emptycart.dart';
import 'package:taswag/provider.dart';
import 'package:taswag/reviews_input.dart';

class productdetails extends StatefulWidget {
  final price;
  final prductname;
  final productid;

  productdetails({this.prductname, this.price, this.productid});

  @override
  _productdetailsState createState() => _productdetailsState();
}

class _productdetailsState extends State<productdetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int index1;

  @override
  void initState() {
    super.initState();
    getreiewsdata = _postrview();
  }

  int _counter;

  _incrementCounter(val) {
    setState(() {
      val = _counter++;
    });
    print(val);
  }

  bool favroute = false;
  var quntity = " 1 ";
  Future getreiewsdata;

  Stream getOrdersStrem(Duration refreshTime) async* {
    while (true) {
      await Future.delayed(refreshTime);
      yield await _postrview();
    }
  }

  Future _cartpost() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('data');
      print(token);

      var qunatity = '${quntity.toString()}';
      print(qunatity);
      final queryParameters = {
        'quantity': quntity.toString(),
      };
      Map<String, String> quantity = {"quantity": ' '};
      var authorizations = await http.post(
        Uri.encodeFull(
            'http://grocery.taswog.com/api/cartItems/' + '${widget.productid}'),
        headers: {
          "Authorization": "Bearer $token",
          'accept': 'application/json',
        },
        body: {
          'quantity': quntity,
        },
      );
      var responseJson = await json.decode(authorizations.body);
      var data = responseJson['data'];
      var product = data;
      print(product);
      return product;
    } catch (e) {
      print(e);
    }
  }

  Future _addtoWishlist() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('data');
      print(token);
      var qunatity = '${quntity.toString()}';
      print(qunatity);
      final queryParameters = {
        'quantity': quntity.toString(),
      };
      Map<String, String> quantity = {"quantity": ' '};
      var authorizations = await http.post(
        Uri.encodeFull('http://grocery.taswog.com/api/wishListItems/' +
            '${widget.productid}'),
        headers: {
          "Authorization": "Bearer $token",
          'accept': 'application/json',
        },
      );
      var responseJson = await json.decode(authorizations.body);
      setState(() {
        favroute = true;
      });
      var data = responseJson['message'];
      var product = data;
      print(product);
      return product;
    } catch (e) {
      print(e);
    }
  }

  Future _postrview() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('data');
      print(token);
      var authorizations = await http.get(
        // 'grocery.taswog.com/api/product/40/reviews',
        'http://grocery.taswog.com/api/product/' +
            '${widget.productid}' +
            '/reviews',
        headers: {
          "Authorization": "Bearer $token",
          'Content-Type': 'application/json'
        },
      );
      var responseJson = await json.decode(authorizations.body);
      var data = responseJson['data'];
      var product = data;
      return product;
    } catch (e) {
      print(e);
    }
  }

  ScrollController _controller = new ScrollController();

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

  Stream getcartstream(Duration refreshTime) async* {
    while (true) {
      await Future.delayed(refreshTime);
      yield await getcartitem();
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EligiblityScreenProvider>(
        create: (context) => EligiblityScreenProvider(),
        child: Builder(builder: (context) {
          return Scaffold(
              key: _scaffoldKey,
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
                  //cart
                  Consumer<EligiblityScreenProvider>(
                      builder: (context, provider, child) {
                        return
                          StreamBuilder(
                              stream: getcartstream(Duration(
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
                                                pageBuilder: (context,
                                                    animation,
                                                    animationtime) =>
                                                    emptycart(),
                                                transitionsBuilder: (context,
                                                    animation,
                                                    animationtime, child) {
                                                  animation = CurvedAnimation(
                                                      parent: animation,
                                                      curve: Curves
                                                          .elasticInOut);
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
                                            builder: (context,) =>
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
                              });
                      })
                ],
                //cart
                title: Center(
                    child: Text('Barkat',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'sans-serif-condensed'))),
              ),
              body: Consumer<EligiblityScreenProvider>(
                builder: (context, provider, child) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            child: Column(children: [
                              Center(
                                child: Container(
                                  child: Image.asset(
                                    'assets/barkat.png',
                                  ),
                                ),
                              ),
                              Container(
                                  child: Column(
                                    children: [
                                      ListTile(
                                        trailing: favroute
                                            ? IconButton(
                                            color: Colors.purple,
                                            icon: Icon(Icons.favorite_border),
                                            onPressed: _addtoWishlist)
                                            : IconButton(
                                            color: Colors.black,
                                            icon: Icon(Icons.favorite_border),
                                            onPressed: _addtoWishlist),
                                        leading: Text(
                                          '${widget.prductname.toString()}',
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontFamily: 'sans-serif-condensed'),
                                        ),
                                      ),

                                      Container(
                                        margin: EdgeInsets.only(left: 15),
                                        child: Row(
                                          children: [
                                            Container(
                                                child: Text(
                                                  ' 5 Piece',
                                                  style:
                                                  TextStyle(
                                                      fontFamily: 'sans-serif'),
                                                )),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                                child: Text(
                                                  ' ${widget.price}',
                                                  style:
                                                  TextStyle(
                                                      fontFamily: 'sans-serif'),
                                                )),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            IconButton(
                                                iconSize: 20,
                                                color: Colors.yellow,
                                                icon: Icon(Icons.star),
                                                onPressed: () {}),
                                            IconButton(
                                                iconSize: 20,
                                                color: Colors.yellow,
                                                icon: Icon(Icons.star),
                                                onPressed: () {}),
                                            IconButton(
                                                iconSize: 20,
                                                color: Colors.yellow,
                                                icon: Icon(Icons.star),
                                                onPressed: () {}),
                                            IconButton(
                                                iconSize: 20,
                                                color: Colors.yellow,
                                                icon: Icon(Icons.star_border),
                                                onPressed: () {})
                                          ],
                                        ),
                                      ),
                                      //  new

                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius
                                                  .circular(15),
                                            ),
                                            child: IconButton(
                                              onPressed: () {
                                                _incrementCounter(index1);
                                                print((index1));
                                              },
                                              color: Colors.orange,
                                              icon: Icon(Icons.add),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text('1',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20)),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius
                                                  .circular(15),
                                            ),
                                            child: IconButton(
                                              onPressed: () {},
                                              color: Colors.orange,
                                              icon: Icon(Icons.remove),
                                            ),
                                          ),
                                        ],
                                      ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .end,
                                        children: [
                                          Text('PKR 700 ',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontFamily: 'sans-serif-condensed')),
                                        ],
                                      ),

                                      Container(
                                        margin: EdgeInsets.only(left: 15),
                                        child: Row(
                                          children: [
                                            Text('Product Details'),
                                            IconButton(
                                                icon: Icon(
                                                    Icons.arrow_drop_down),
                                                onPressed: () {}),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text(
                                              ' Lorem Ipsum is simply dummy text of the printing  ',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w300,
                                                  fontFamily: 'Superclarendon'),
                                            ),
                                            Text(
                                              ' Lorem Ipsum is simply dummy text of the printing Lore  ',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w300,
                                                  fontFamily: 'Superclarendon'),
                                            ),
                                            Text(
                                              ' Lorem Ipsum is simply    ',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w300,
                                                  fontFamily: 'Superclarendon'),
                                            ),
                                          ],
                                        ),
                                      )
                                      //  new
                                    ],
                                  )),
                              SizedBox(
                                height: 40,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text('Reviews'),
                                    Icon(Icons.arrow_drop_down),
                                  ],
                                ),
                              ),
                            ])),
                        Consumer<EligiblityScreenProvider>(
                            builder: (context, provider, child) {
                              return FutureBuilder(
                                  future: _postrview(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    } else {
                                      print(' link${snapshot.data}   ');
                                    }
                                    return ListView.builder(
                                        primary: false,
                                        physics: const NeverScrollableScrollPhysics(),
                                        controller: _controller,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        padding: EdgeInsets.all(8),
                                        itemCount: snapshot.data.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 20),
                                                    child: Text(
                                                        " ${snapshot
                                                            .data[index]['customer']}")),
                                                Row(
                                                  children: [
                                                    IconButton(
                                                        color: Colors.yellow,
                                                        icon: Icon(Icons.star),
                                                        onPressed: () {}),
                                                    IconButton(
                                                        color: Colors.yellow,
                                                        icon: Icon(Icons.star),
                                                        onPressed: () {}),
                                                    IconButton(
                                                        color: Colors.yellow,
                                                        icon: Icon(
                                                            Icons.star_border),
                                                        onPressed: () {}),
                                                    IconButton(
                                                        color: Colors.yellow,
                                                        icon: Icon(
                                                            Icons.star_border),
                                                        onPressed: () {}),
                                                  ],
                                                ),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 18),
                                                    child: Text(
                                                      '  ${snapshot
                                                          .data[index]['body']}',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .w300,
                                                          fontSize: 12,
                                                          fontFamily:
                                                          'Chalkboard SE'),
                                                    )),
                                                // Container(
                                                //   margin: EdgeInsets.only(left: 18),
                                                //   child: Text(
                                                //     'typesetting industry.',
                                                //     style: TextStyle(
                                                //         fontWeight: FontWeight.w300,
                                                //         fontSize: 12,
                                                //         fontFamily: 'Chalkboard SE'),
                                                //   ),
                                                // ),

                                                SizedBox(
                                                  height: 20,
                                                ),

                                                // Container(
                                                //   margin: EdgeInsets.only(
                                                //     left: 20,
                                                //   ),
                                                //   child: Row(
                                                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                //     children: [
                                                //       Text('Write your review'),
                                                //       Icon(Icons.create),
                                                //     ],
                                                //   ),
                                                // ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                // Padding(
                                                //   padding: const EdgeInsets.only(left: 40, right: 40),
                                                //   child: InkWell(
                                                //     onTap: () {
                                                //       Navigator.push(
                                                //           context,
                                                //           PageRouteBuilder(
                                                //               transitionDuration: Duration(seconds: 2),
                                                //               pageBuilder:
                                                //                   (context, animation, animationtime) =>
                                                //                       review_input(),
                                                //               transitionsBuilder:
                                                //                   (context, animation, animationtime, child) {
                                                //                 animation = CurvedAnimation(
                                                //                     parent: animation,
                                                //                     curve: Curves.elasticInOut);
                                                //                 return ScaleTransition(
                                                //                   scale: animation,
                                                //                   child: child,
                                                //                   alignment: Alignment.center,
                                                //                 );
                                                //               }));
                                                //     },
                                                //     child: Container(
                                                //       child: Text(
                                                //         'Would you like to write anything about this product?',
                                                //         style: TextStyle(color: Colors.grey),
                                                //       ),
                                                //       // child: TextField(
                                                //       //   style: TextStyle(fontSize: 12),
                                                //       //   showCursor: false,
                                                //       //   decoration: InputDecoration(
                                                //       //       hintText:
                                                //       //           'Would you like to write anything about this product?'),
                                                //       //  ),
                                                //     ),
                                                //   ),
                                                // )
                                              ],
                                            ),
                                          );
                                        });
                                  });
                            }),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                left: 20,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Write your review'),
                                  Icon(Icons.create),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 40, right: 40),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                          transitionDuration:
                                          Duration(seconds: 2),
                                          pageBuilder: (context, animation,
                                              animationtime) =>
                                              review_input(
                                                productid: widget.productid,
                                              ),
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
                                          })).then((value) => setState(() {}));
                                },
                                child: Container(
                                  child: Text(
                                    'Would you like to write anything about this product?',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  // child: TextField(
                                  //   style: TextStyle(fontSize: 12),
                                  //   showCursor: false,
                                  //   decoration: InputDecoration(
                                  //       hintText:
                                  //           'Would you like to write anything about this product?'),
                                  //  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          width: 200,
                          child: MaterialButton(
                            onPressed: () {
                              setState(() {
                                _cartpost();
                              });
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text(' item added to cart'),
                                backgroundColor: Colors.orange,
                              ));
                            },
                            color: Colors.orange,
                            textColor: Colors.white,
                            elevation: 0.2,
                            child: Text(
                              'add to Cart',
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ));
        }));
  }
}
