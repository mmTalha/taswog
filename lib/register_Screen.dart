import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taswag/botom_tab_bar.dart';
import 'package:http/http.dart ' as http;

import 'package:taswag/main.dart';
import 'package:taswag/productpage.dart';

class Register_Screen extends StatefulWidget {
  @override
  _Register_ScreenState createState() => _Register_ScreenState();
}

class _Register_ScreenState extends State<Register_Screen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _username = TextEditingController();
    TextEditingController _Email = TextEditingController();
    TextEditingController _password = TextEditingController();
    TextEditingController _confirmpassword = TextEditingController();
    final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

// postTest() async {
//   final uri = 'grocery.taswog.com/api/register-demo';
//   var requestBody = {
//     'name': _username.text,
//       'email': _Email.text,
//          'password': _password.text
//   };
//
//   http.Response response = await http.post(
//     uri,
//     body: json.encode(requestBody),
//   );
//
//   print(response.body);
// }

    Future RegistrationUser() async {
      // url to registration php script
      try {
        var APIURL = 'http://grocery.taswog.com/api/register';

        //json maping user entered details
        Map mapeddate = {
          'name': _username.text,
          'email': _Email.text,
          'password': _password.text,
          "password_confirmation": _confirmpassword.text,

        };
        //send  data using http post to our php code
        var reponse = await http.post(APIURL, body: (mapeddate), headers: {
          "Accept": "application/json",
        });

        print(reponse.body);

        _username.clear();
        _Email.clear();
        _password.clear();
        _confirmpassword.clear();
      } catch (e) {
        print(e.toString());
      }
    }

// List data;
//
// Future<String> getData() async {
//   var response = await http.post(
//       Uri.encodeFull("https://jsonplaceholder.typicode.com/albums/1"),
//       headers: {
//         "Accept": "application/json"
//       }
//   );
//
//   print( response.body);
//
//   return "Success!";
// }

    return Scaffold(
      key: _formkey,
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/Taswog Logo.png'),
                  ],
                ),
                SizedBox(height: 3),
                Center(
                    child: Text(
                  'Signup',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w500  ),
                )),
                SizedBox(height: 5),
                Center(
                    child: Text(

                  'Enter Your Credential to countinue',
                  style: TextStyle(fontFamily: 'Gill Sans',fontSize: 12),
                )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(21.0),
              child: TextField(
                controller: _username,
                decoration: InputDecoration(
                  hintStyle:  TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 14),
                  hintText: 'User name',
                  labelText: 'Username',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(21.0),
              child: TextFormField(

                controller: _Email,
                decoration: InputDecoration(
                  hintStyle:  TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 14),
                  hintText: 'Email',
                  labelText: 'Email',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(21.0),
              child: TextField(
                controller: _password,
                obscureText: true,
                decoration: InputDecoration(
                  hintStyle:  TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 14),
                  hintText: 'Password',
                  labelText: 'Password',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(21.0),
              child: TextField(
                controller: _confirmpassword,
                decoration: InputDecoration(
                  hintStyle:  TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 14),
                  hintText: 'confirm password',
                  labelText: 'confirm password',
                ),
              ),
            ),
            Text(
              'By contiouning you agree to our Terms and services ',
              style: TextStyle(fontFamily: 'Gill Sans'),
            ),
            Text(
              'and privacy Policy',
              style: TextStyle(fontFamily: 'Gill Sans'),
            ),
            Container(
              margin: EdgeInsets.only(top: 70),
              height: 36,
              width: 164,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.orange,
                child: Text(
                  'Signup',
                  style:
                      TextStyle(color: Colors.white, fontFamily: 'Geeza Pro'),
                ),
                onPressed: () {
                  RegistrationUser();
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(height: 15),
            Container(
              margin:  EdgeInsets.only(left: 100 )     ,
              child: Row(

                children: [
                  Text(
                    'Already have a Account an account?',
                    style: TextStyle(color: Colors.grey,fontSize: 10),
                  ),
                   GestureDetector(

                    onTap : () {
                      Navigator.push (
                          context,
                          PageRouteBuilder(
                              transitionDuration: Duration(seconds: 2),
                              pageBuilder:
                                  (context, animation, animationtime) =>
                                      signInPage(),
                              transitionsBuilder:
                                  (context, animation, animationtime, child) {
                                animation = CurvedAnimation(
                                    parent: animation, curve: Curves.elasticIn);
                                return ScaleTransition(
                                  scale: animation,
                                  child: child,
                                  alignment: Alignment.center,
                                );
                              }));
                    },

                    child: Text('login',style: TextStyle(color: Colors.purple,fontSize: 14,fontWeight: FontWeight.w400),),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
