import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:taswag/cartscreen.dart';
import 'package:taswag/emptycart.dart';

class notification extends StatefulWidget {
  @override
  _notificationState createState() => _notificationState();
}


class _notificationState extends State<notification> {
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

  Future getnotify()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('data');
    print(token);
    var authorizations = await http.get(
        'http://grocery.taswog.com/api/get-notification' ,
        headers: {
          'Accept':'application/json',
          "Authorization": "Bearer  $token"
        }
    );
    var responseJsons = await json.decode(authorizations.body);
    print(responseJsons[  "notifcations" ]  );
    return responseJsons[  "notifcations" ]  ;

  }


  void initState() {
    super.initState();
    getnotify();
  }

  var Product_list = [
  {

   'picture' : 'assets/notification_img.png',
   'detail': ' lorem polemm dummy text which no on euncesssfsyvffsvffv ',
    'name1':'notification1'


   },
   {

  'picture' : 'assets/notification_img.png',
  'detail':   ' lorem polemm dummy text which no on euncesssfsyvffsvffv ',
     'name1':'notification1'

   },];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
            child: Text(
              'Notifications',
              style: TextStyle(color: Colors.black),
            )),
        leading: IconButton(
            icon: Icon(Icons.arrow_back), color: Colors.black, onPressed: null),
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

              }),
        ],
      ),
      body:
      FutureBuilder(
        future: getnotify()  ,
           builder: (context, snapshot) {
             if (!snapshot.hasData) {
               return Center(child: CircularProgressIndicator());
             } else {
               print(' link${snapshot.data}   ');
             }
             return ListView.builder(
                 scrollDirection: Axis.vertical,
                 padding: EdgeInsets.all(8),
                 itemCount: snapshot.data.length,
                 itemBuilder: (BuildContext context, int index) {
                   return InkWell(
                     child:
                     ListTile(
                       title: Text('${snapshot.data[index]['notification name']},     ',
                         style: TextStyle(color: Colors.black,
                             fontWeight: FontWeight.bold),),
                       leading: Image.asset(Product_list[index]['picture'],),
                       subtitle: Text('${snapshot.data[index]['notification description']},     '),
                     ),
                   );
                 });
           }),
    );
  }
}
