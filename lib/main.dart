import 'dart:async';
import 'dart:convert';

import 'dart:typed_data';
import 'package:flutter/painting.dart';
import 'package:http/http.dart ' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taswag/botom_tab_bar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:taswag/productapi.dart';
import 'package:taswag/productpage.dart';
import 'package:taswag/profile_model.dart';
import 'package:taswag/provider.dart';
import 'package:taswag/recovery_password.dart';
import 'package:taswag/register_Screen.dart';
import 'package:taswag/subcategory.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => EligiblityScreenProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: spalsh(),
    );
  }
}

class spalsh extends StatefulWidget {
  @override
  _spalshState createState() => _spalshState();
}

class _spalshState extends State<spalsh> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(seconds: 2),
                pageBuilder: (context, animation, animationtime) => started(),
                transitionsBuilder: (context, animation, animationtime, child) {
                  animation = CurvedAnimation(
                      parent: animation, curve: Curves.bounceIn);
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                    alignment: Alignment.center,
                  );
                })));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/splash.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken)),
      ),
      child: Center(
        child: Image.asset('assets/taswag.png'),
      ),
    );
  }
}

class started extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/splash.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken)),
        ),
        child: Container(
          margin: EdgeInsets.only(top: 170),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/taswag.png'),
              Text(
                'Welcome',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  fontFamily: 'Times New Roman',
                ),
              ),
              Text(
                ' to our store',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontFamily: 'Times New Roman',
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                child: Text(
                  'Ger your groceries in as fast as one hour',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontFamily: 'PingFang HK',
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 120),
                    height: 50,
                    width: 180,
                    child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: Colors.orange,
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Geeza Pro'),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                  transitionDuration: Duration(seconds: 2),
                                  pageBuilder:
                                      (context, animation, animationtime) =>
                                          tab_bar(),
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
                        }),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class signInPage extends StatefulWidget {
  @override
  _signInPageState createState() => _signInPageState();
}

class _signInPageState extends State<signInPage> {
  Future fetchData() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/albums');
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return jsonResponse;
      // return jsonResponse.map((data) => new Photo.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<Photo>> futureData;
  @override
  // void initState() {
  //   super.initState();
  //   futureData = fetchData();
  // }

  bool _isLoading = false;
  final TextEditingController Email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final _storage = new FlutterSecureStorage();

  //login api real function

  signIn(
    String email,
    pass,
  ) async {

      _isLoading = true;

    Map data = {
      'email':  'talhaharoon767+',
      'password': pass,
    };

    var jsonResponse = null;
    var response = await http.post(
      "http://grocery.taswog.com/api/login",
      body: data,
    );
    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      // print(jsonResponse['data' ]['token']);
      // print(jsonResponse['data' ]['user' ]['verify']);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // var email =   prefs.setString('email', jsonResponse['user' ] [ 'verify'] );
      // print(email);

      prefs.setString('data', jsonResponse['data']['token']);

      print(jsonResponse.toString());

      try {
        if (jsonResponse != null) {
          setState(() {
            _isLoading = false;
          });

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => tab_bar()),
              (Route<dynamic> route) => false);
        } else {
          setState(() {
            _isLoading = false;
          });
          print(jsonResponse);
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  //  Future   token() async {
  //    Photo profileModel = Photo();
  //    SharedPreferences prefs = await SharedPreferences.getInstance();
  //    var token = prefs.getString('data');
  //    print(token);
  //    var authorizations = await http.get(
  //      'http://grocery.taswog.com/api/get-all-products',
  //       headers: {
  //         "Authorization": "Bearer $token",
  //      },
  //    );
  //    var responseJson = await json.decode(authorizations.body);
  //    List data = responseJson[ "data" ]  ;
  // var product = data ;
  //    return  product ;
  //  }
  //
  //
  //  // return responseJson. map((data) => new Photo.fromJson(data)).toList();
  //
  //  void initState() {
  //    super.initState();
  //    token();
  //
  //  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:
          // FutureBuilder(
          //     future: token(),
          //     builder: (context, snapshot) {
          //       if (!snapshot.hasData) {
          //         return Center(child: CircularProgressIndicator());
          //       } else {
          //         print(' link${snapshot.data}   '    );
          //       }
          //         return
          Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/Taswog Logo.png'),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                    child: Text(
                  ' login',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                  ),
                )),
                SizedBox(
                  height: 5,
                ),
                Center(
                    child: Text(
                  'Enter your Email and Password',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(
              controller: Email,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
                hintText: 'Email',
                focusColor: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              controller: password,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
                hintText: 'Password',
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                      transitionDuration: Duration(seconds: 2),
                      pageBuilder: (context, animation, animationtime) =>
                          recovery_password(),
                      transitionsBuilder:
                          (context, animation, animationtime, child) {
                        animation = CurvedAnimation(
                            parent: animation, curve: Curves.elasticInOut);
                        return ScaleTransition(
                          scale: animation,
                          child: child,
                          alignment: Alignment.center,
                        );
                      }));
            },
            child: Container(
                padding: EdgeInsets.only(left: 210),
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.blue),
                )),
          ),
          Column(
            children: [
              _isLoading
                  ? CircularProgressIndicator(
                      backgroundColor: Colors.orange,
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.orange),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 120),
                      height: 36,
                      width: 165,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.orange,
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Geeza Pro'),
                        ),
                        onPressed: () {
                          signIn(
                            Email.text,
                            password.text,
                          );
                        },
                      ),
                    ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(left: 100),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Not a Member yet?',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  transitionDuration: Duration(seconds: 2),
                                  pageBuilder:
                                      (context, animation, animationtime) =>
                                          Register_Screen(),
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
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
      // } ),
    );
  }
}
