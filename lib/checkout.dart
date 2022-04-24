import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taswag/Stepper_two.dart';
import 'package:taswag/botom_tab_bar.dart';
import 'package:taswag/productpage.dart';

import 'provider.dart';

class Checkout_screen extends StatefulWidget {
  @override
  _Checkout_screenState createState() => _Checkout_screenState();
}

class _Checkout_screenState extends State<Checkout_screen> {
  Future addressget;
  bool isClicked = false;
  final TextEditingController address = TextEditingController();
  final TextEditingController phoneno = TextEditingController();
  final TextEditingController name = TextEditingController();
  bool valuefirst = false;
  bool valuesecond = false;
  var orderid;
  var time;
  var addressid;
  var addressconfirm;
  TextEditingController timeinput = TextEditingController();
  int _selectedIndex = 0;
  Future fakedata;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  void initState() {
    timeinput.text = ""; //s

    super.initState();
  }

  // void _selectTime() async {
  //   final TimeOfDay newTime = await showTimePicker(
  //     context: context,
  //     initialTime: _time,
  //   );
  //   if (newTime != null) {
  //
  //     setState(() {
  //       _time = newTime;
  //     });
  //
  //     print(_time.hour  );
  //
  //   }
  // }

  String days;

  // api
  Future checkout(date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('data');
    print(token);

    print(days);
    var authorizations = await http.post(
      'http://grocery.taswog.com/api/checkout-time-slot?delivery_day=${days}&delivery_time=${date}',
      headers: {
        'Accept': 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    var responseJson = await json.decode(authorizations.body);
    var data = responseJson['message'];
    var product = data;
    print(product);
    print(orderid);
    return product;
  }

  Future getadressid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('data');
    print(token);
    print(addressid);
    print(addressconfirm);
    var authorizations = await http.get(
      'http://grocery.taswog.com/api/get-delivery-address',
      headers: {
        'Accept': 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    var responseJson = await json.decode(authorizations.body);
    List data = responseJson['addresses'];
    var product = data;

    return product;
  }

  postorders(String office, String number, String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('data');
    print(token);
    Map datas = {
      'address': office,
      'number': number,
      'name': name,
    };
    var authorizations = await http.post(
      'http://grocery.taswog.com/api/delivery-address',
      body: datas,
      // 'http://grocery.taswog.com/api/checkout-confirm-order?user_address_id='+'12 ' + '&delivery_address=' '${office} '  ,
      // 'http://grocery.taswog.com/api/checkout-confirm-order?user_address_id= 12&delivery_address=office',
      // body: {
      //   'review': address,
      //
      //
      //
      // },

      headers: {
        'Accept': 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    var responseJson = await json.decode(authorizations.body);
    var data = responseJson['message'];
    var product = data;
    print(product);
    return product;
  }

  Future confirmorder() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('data');
      print(token);
      print(addressid);
      print(addressconfirm);
      var authorizations = await http.post(
        'http://grocery.taswog.com/api/checkout-confirm-order?user_address_id=' +
            '${addressid} ' +
            '&delivery_address=' '${addressconfirm} ',
        headers: {
          'Accept': 'application/json',
          "Authorization": "Bearer $token",
        },
      );
      var responseJson = await json.decode(authorizations.body);
      var data = responseJson['message'];
      var product = data;
      print(product);
      return product;
    } catch (e) {
      print(e.toString());
    }
  }

// api

  var Product_list = [
    {
      ' name': 'Monday',
      'picture': 'images/products/blazer1.jpeg',
      'Old price': '760',
      'Price': '760',
      'name2': 'Monday'
    },
    {
      ' name': "Tuesday",
      'picture': 'images/products/blazer2.jpeg',
      'name2': 'Tuesday',
      'Price': '760',
      'Old price': '760'
    },
    {
      ' name': "wednesday",
      'picture': 'images/products/dress2.jpeg',
      'name2': 'wednesday',
      'Price': '760',
      'Old price': '760'
    },
    {
      ' name': "Thursday",
      'picture': 'images/products/shoe1.jpg',
      'name2': 'Thursday',
      'Price': '760',
      'Old price': '760'
    },
    {
      ' name': "Friday",
      'picture': ' november 8',
      'name2': 'Friday',
      'colour': Colors.orange[50],
    },
    {
      ' name': "Saturday",
      'picture': ' november 9',
      'name2': 'Saturday',
      'Price': '760',
      'Old price': '760'
    },
  ];

  int _currentStep = 0;
  int stepCounter = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EligiblityScreenProvider>(
        create: (context) => EligiblityScreenProvider(),
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                'Checkout',
                style: TextStyle(color: Colors.black),
              ),
              leading:
                  IconButton(icon: Icon(Icons.arrow_back), onPressed: null),
            ),
            body: Consumer<EligiblityScreenProvider>(
                builder: (context, provider, child) {
              return Container(
                child: Theme(
                  data: ThemeData(
                      primarySwatch: Colors.orange,
                      colorScheme: ColorScheme.light(primary: Colors.orange)),
                  child: new Stepper(
                    type: StepperType.horizontal,
                    controlsBuilder: (BuildContext context,
                        {VoidCallback onStepContinue,
                        VoidCallback onStepCancel}) {
                      return Row(
                        children: <Widget>[
                          // FlatButton(
                          //
                          //
                          //
                          //
                          //
                          //
                          //
                          //   child: const Text('NEXT'),
                          //   onPressed: () {
                          //     continued();
                          //     checkout(timeinput.text);
                          //   }
                          //
                          //
                          // ),
                          // FlatButton(
                          //   onPressed: _currentStep > 0
                          //       ? () => setState(() => _currentStep -= 1)
                          //       : null,
                          //   child: const Text('EXIT'),
                          // ),
                        ],
                      );
                    },
                    onStepCancel: _currentStep > 0
                        ? () => setState(() => _currentStep -= 1)
                        : null,
                    currentStep: _currentStep,
                    onStepTapped: (int step) =>
                        setState(() => _currentStep = step),
                    onStepContinue: _currentStep < 2
                        ? () => setState(() => _currentStep += 1)
                        : null,
                    // onStepCancel: _currentStep > 0 ? () => setState(() => _currentStep -= 1) : null,
                    steps: <Step>[
                      new Step(
                        subtitle: Text(
                          'Select Delivery time',
                          style: TextStyle(fontSize: 10),
                        ),
                        title: Text('Time slot'),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('select your delevery timing'),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Text('deleveryday'),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 70,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: Product_list.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return category(
                                      color: _selectedIndex != null &&
                                              _selectedIndex == index
                                          ? Colors.pink[50]
                                          : Colors.purple[50],
                                      ontap: () {
                                        print(
                                            '${Product_list[index]['name2']},');
                                        setState(() {
                                          days = Product_list[index]['name2'];
                                          print(days);
                                          setState(() {});
                                        });
                                        _onSelected(index);
                                      },
                                      image_caption:
                                          '${Product_list[index]['name2']},',
                                      image_location:
                                          '${Product_list[index]['name2']},',
                                    );

                                    // InkWell(
                                    //
                                    //   child: Container(
                                    //     decoration: BoxDecoration(
                                    //         color: Colors.pink[300],
                                    //         borderRadius: BorderRadius
                                    //             .circular(5)),
                                    //     height: 40,
                                    //     width: 100,
                                    //     child: Column(
                                    //       mainAxisAlignment: MainAxisAlignment
                                    //           .center,
                                    //       children: [
                                    //         Text( Product_list[index]['name2']),
                                    //         Text(Product_list[index]['name2']),
                                    //       ],
                                    //     ),
                                    //   ),
                                    //   onTap: (){
                                    //     print(  Product_list[index]['name2'] );
                                    //     print(  Product_list[index]['name2'] );
                                    //   },
                                    // );
                                    // SizedBox(
                                    //   width: 10,
                                    // ),
                                    // Container(
                                    //   decoration: BoxDecoration(
                                    //       color: Colors.pink[300],
                                    //       borderRadius: BorderRadius
                                    //           .circular(5)),
                                    //   height: 40,
                                    //   width: 100,
                                    //   child: Column(
                                    //     children: [
                                    //       Text('Monday'),
                                    //       Text('9th november')
                                    //     ],
                                    //   ),
                                    // ),
                                    // SizedBox(
                                    //   width: 10,
                                    // ),
                                    // Container(
                                    //   decoration: BoxDecoration(
                                    //       color: Colors.pink[300],
                                    //       borderRadius: BorderRadius
                                    //           .circular(5)),
                                    //   height: 40,
                                    //   width: 100,
                                    //   child: Column(
                                    //     children: [
                                    //       Text('Monday'),
                                    //       Text('9th november')
                                    //     ],
                                    //   ),
                                    // ),
                                    // SizedBox(
                                    //   width: 10,
                                    // ),
                                    // Container(
                                    //   decoration: BoxDecoration(
                                    //       color: Colors.pink[300],
                                    //       borderRadius: BorderRadius
                                    //           .circular(5)),
                                    //   height: 40,
                                    //   width: 100,
                                    //   child: Column(
                                    //     children: [
                                    //       Text('Monday'),
                                    //       Text('9th november')
                                    //     ],
                                    //   ),
                                    // ),
                                    // SizedBox(
                                    //   width: 10,
                                    // ),
                                    // InkWell(
                                    //   child: Container(
                                    //     decoration: BoxDecoration(
                                    //         color: Colors.pink[300],
                                    //         borderRadius: BorderRadius
                                    //             .circular(5)),
                                    //     height: 40,
                                    //     width: 100,
                                    //     child: Column(
                                    //       children: [
                                    //         Text('Monday'),
                                    //         Text('9th november')
                                    //       ],
                                    //     ),
                                    //   ),
                                    //   ),
                                  }),
                            ),

                            SizedBox(
                              height: 20,
                            ),
                            Text('Timing'),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 50,
                              child: TextField(
                                controller: timeinput,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.watch_later),
                                    onPressed: () async {
                                      TimeOfDay pickedTime =
                                          await showTimePicker(
                                        initialTime: TimeOfDay.now(),
                                        context: context,
                                      );

                                      if (pickedTime != null) {
                                        print(pickedTime
                                            .format(context)); //output 10:51 PM
                                        DateTime parsedTime = DateFormat.jm()
                                            .parse(pickedTime
                                                .format(context)
                                                .toString());
                                        //converting to DateTime so that we can further format on different pattern.
                                        print(
                                            parsedTime); //output 1970-01-01 22:53:00.000
                                        String formattedTime =
                                            DateFormat('HH:mm:ss')
                                                .format(parsedTime);
                                        print(formattedTime); //output 14:59:00
                                        //DateFormat() is from intl package, you can format the time on any pattern you need.
                                        print(pickedTime);
                                        setState(() {
                                          pickedTime = time;
                                        });
                                        setState(() {
                                          timeinput.text =
                                              formattedTime; //set the value of text field.
                                        });
                                      } else {
                                        print("Time is not selected");
                                      }
                                    },
                                  ),
                                  border: OutlineInputBorder(),
                                  hintText: '10:00-Am-5:00-pm',
                                ),
                              ),
                            ),
                            //button
                            Center(
                              child: FutureBuilder(
                                  future: checkout(timeinput.text),
                                  builder: (context, snapshot) {
                                    return Container(
                                      margin: EdgeInsets.only(top: 220),
                                      height: 50,
                                      width: 220,
                                      child: MaterialButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        color: Colors.orange,
                                        child: Text(
                                          'Place order',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Geeza Pro'),
                                        ),
                                        onPressed: () {
                                          continued();
                                          checkout(timeinput.text);

                                          setState(() {
                                            orderid =
                                                snapshot.data[0]['user_id'];
                                          });
                                        },
                                      ),
                                    );
                                  }),
                            ),

                            //  buttonend
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 0
                            ? StepState.complete
                            : StepState.disabled,
                      ),

                      //new step widget strt

                      new Step(
                        title: new Text('Address'),
                        subtitle: Text(
                          'Address Input',
                          style: TextStyle(fontSize: 10),
                        ),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Select Delivery Address',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.add_box),
                                    onPressed: () {
                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context) {
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Row(
                                                  children: [
                                                    IconButton(
                                                        icon:
                                                            Icon(Icons.remove),
                                                        onPressed: () {}),
                                                    Text('address'),
                                                  ],
                                                ),
                                                Container(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            21.0),
                                                    child: TextField(
                                                      controller: name,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        hintText: 'name',
                                                        labelText: 'name',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            21.0),
                                                    child: TextField(
                                                      controller: address,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        hintText: 'Address',
                                                        labelText: 'Address',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            21.0),
                                                    child: TextField(
                                                      controller: phoneno,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        hintText: 'Phone no',
                                                        labelText: 'Phone no',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 120),
                                                  height: 50,
                                                  width: 220,
                                                  child: MaterialButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                    color: Colors.orange,
                                                    child: Text(
                                                      'Save',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              'Geeza Pro'),
                                                    ),
                                                    onPressed: () {
                                                      postorders(
                                                          address.text,
                                                          name.text,
                                                          phoneno.text);
                                                      address.clear();
                                                      provider.getadressid();

                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                  ),
                                  Text(
                                    'add new address',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              decoration: new BoxDecoration(),
                              child: FutureBuilder(
                                  future: getadressid(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    } else {
                                      print(' link${snapshot.data}   ');
                                    }
                                    print(snapshot.data);
                                    return ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: 2,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Card(
                                            _selectedIndex != null &&
                                                    _selectedIndex == index
                                                ? Colors.pink[50]
                                                : Colors.purple[50],
                                            snapshot.data[index]['address'],
                                            snapshot.data[index]['name'],
                                            () {
                                              // print("${snapshot.data[index]['address']} ");
                                              setState(() {
                                                addressid =
                                                    "${snapshot.data[index]['user_address_id']} ";
                                                addressconfirm =
                                                    "${snapshot.data[index]['address']} ";
                                                isClicked = true;
                                              });
                                              _onSelected(index);
                                            },
                                          );
                                        });
                                  }),
                            ),
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(top: 160),
                                height: 50,
                                width: 220,
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  color: Colors.orange,
                                  child: Text(
                                    'Place order',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Geeza Pro'),
                                  ),
                                  onPressed: () {
                                    confirmorder();
                                    continued();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 1
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      new Step(
                        title: new Text('Confirm'),
                        subtitle: Text(
                          'Check order',
                          style: TextStyle(fontSize: 10),
                        ),
                        content: Center(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/orderlogo.png',
                                ),
                                Text(
                                  'Your order Has Been  ',
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  'Accepted',
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  'your item has been accepted and is on',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey),
                                ),
                                Text(
                                  ' its way to being proceed',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 120),
                                  height: 50,
                                  width: 220,
                                  child: MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    color: Colors.orange,
                                    child: Text(
                                      'Continue Shooping',
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
                                                  tab_bar(),
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
                              ],
                            ),
                          ),
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 2
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        }));
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}

//custome widget

class category extends StatelessWidget {
  bool isClickedme = false;
  final String image_location;
  final String image_caption;
  Function ontap;
  Color color;

  category({this.image_location, this.image_caption, this.ontap, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: ontap,
        child: Container(
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(5)),
          width: 120.0,
          child: ListTile(
            title: Text(
              image_location,
            ),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Text(image_caption),
            ),
          ),
        ),
      ),
    );
  }
}

Widget Card(
  Color color,
  String address,
  String phoneno,
  Function tap,
) {
  return InkWell(
    onTap: tap,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
      ),
      margin: EdgeInsets.all(10),
      width: 303,
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: Row(
            children: [
              Icon(
                Icons.home,
                color: Colors.black,
              ),
              SizedBox(
                width: 10,
              ),
              Text('Home'),
              SizedBox(
                width: 170,
              ),
              // Checkbox(
              //   value: this
              //       .valuefirst,
              //   onChanged: (
              //       bool value) {
              //     setState(() {
              //       isClicked = true;
              //     });
              //     setState(() {
              //       this.valuefirst =
              //           value;
              //     });
              //     setState(() {
              //       isClicked =
              //       false;
              //     });
              //   },
              //
              // ),
            ],
          )),
          SizedBox(
            height: 5,
          ),
          Container(
            child: Text(phoneno),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text(address),
          ),
        ],
      ),
    ),
  );
}
