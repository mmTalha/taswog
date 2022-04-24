import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taswag/contactus.dart';
import 'package:taswag/main.dart';
import 'package:taswag/orderapi_getdata.dart';
import 'package:taswag/profiledetails.dart';
import 'package:taswag/Notification.dart ';

class details extends StatefulWidget {
  @override
  _detailsState createState() => _detailsState();
}

class _detailsState extends State<details> {
  Future getdetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('data');
    print(token);
    var authorizations = await http.get(
      'http://grocery.taswog.com/api/get-my-details',
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    var responseJson = await json.decode(authorizations.body);
    List data = responseJson;
    var product = data;
    print('godd$product ');
    return product;
  }

  @override
  Widget build(BuildContext context) {
    bool isloading = false;

    return Scaffold(
        body: FutureBuilder(
            future: getdetails(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                print(' link${snapshot.data}   ');
              }
              return ListView(children: [
                UserAccountsDrawerHeader(
                  accountName: Text(snapshot.data[0]['name']),
                  accountEmail: Text(snapshot.data[0]['email']),
                  currentAccountPicture: GestureDetector(
                    child: new CircleAvatar(
                      backgroundImage: AssetImage('assets/woman .png'),
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person),
                    ),
                  ),
                  decoration: new BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/woman .png'),
                        fit: BoxFit.cover,
                        colorFilter:
                            ColorFilter.mode(Colors.black54, BlendMode.darken)),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (
                          context,
                        ) =>
                            orderapi(),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text('my orders'),
                    leading: Icon(Icons.person_add, color: Colors.grey),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            transitionDuration: Duration(seconds: 2),
                            pageBuilder: (context, animation, animationtime) =>
                                profliledetails(
                                  useremail: snapshot.data[0]['contact'],
                                  username: snapshot.data[0]['name'],
                                  userpass: snapshot.data[0]['password'],
                                ),
                            transitionsBuilder:
                                (context, animation, animationtime, child) {
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
                  child: ListTile(
                    title: Text('profile details'),
                    leading:  Icon(Icons.person  )  ,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: Text(' Delivery address'),
                    leading: Icon(Icons.bookmark_border, color: Colors.grey),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            transitionDuration: Duration(seconds: 2),
                            pageBuilder: (context, animation, animationtime) =>
                                notification(),
                            transitionsBuilder:
                                (context, animation, animationtime, child) {
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
                  child: ListTile(
                    title: Text('promo code'),
                    leading: Icon(Icons.tag_faces, color: Colors.grey),
                  ),
                ),
                InkWell(
                  child: ListTile(
                    title: Text('contact us'),
                    leading: Icon(Icons.contacts, color: Colors.grey),
                    onTap:  (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (
                          context,
                      ) =>
                          contactus(),
                      ),);
                    }

                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: Text('Terms and condition'),
                    leading: Icon(Icons.fingerprint),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: Text('About'),
                    leading: Icon(Icons.help),
                  ),
                ),
                isloading
                    ? CircularProgressIndicator(
                        backgroundColor: Colors.orange,
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.white54),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(left: 80, right: 80),
                        child: Container(
                          height: 50,
                          width: 20,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            color: Colors.orange,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      child: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  )),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Logout',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Geeza Pro'),
                                  ),
                                ]),
                            onPressed: () async {
                              setState(() {
                                isloading = true;
                              });
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              var token = prefs.getString('data');

                              var authorizations = await http.post(
                                'http://grocery.taswog.com/api/logout',
                                headers: {
                                  "Authorization": "Bearer $token",
                                  'accept': 'application/json'
                                },
                              );

                              if (authorizations.statusCode == 200) {
                                var responseJson =
                                    await json.decode(authorizations.body);
                                setState(() {
                                  isloading = false;
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => signInPage()),
                                );
                              }
                            },
                          ),
                        ),
                      )
              ]);
            }));
  }
}
