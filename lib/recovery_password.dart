import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taswag/productapi.dart';

class recovery_password extends StatefulWidget {
  @override
  _recovery_passwordState createState() => _recovery_passwordState();
}

class _recovery_passwordState extends State<recovery_password> {
  void showAlertDialogOnOkCallback(String title, String msg,
      DialogType dialogType, BuildContext context, VoidCallback onOkPress) {
    AwesomeDialog(
      context: context,
      animType: AnimType.TOPSLIDE,
      dialogType: dialogType,
      tittle: title,
      desc: msg,
      btnOkIcon: Icons.check_circle,
      btnOkColor: Colors.orange,
      btnOkOnPress: onOkPress,
    ).show();
  }

  recoverypass(String email) async {
    var jsonResponse = null;

    Map data = {
      'email': 'talhaharoon767@gmail.com',
    };
    var response = await http.post(
      'http://grocery.taswog.com/api/reset-emails',
      headers: {   'Content-Type': 'application/json',

        'Charset': 'utf-8'},body: data,
     );
    jsonResponse = await json.decode(response.body.toString());
    print(jsonResponse);
  }

  TextEditingController user = TextEditingController();
  String verifylink;
  Future checkUser() async {
    if (user.text.isNotEmpty) {
      var response = await http.post(
          'http://grocery.taswog.com/api/reset-emails',
          headers:{'content-type':'application/json',} ,
          body: {"username": user.text});
      var link = json.encode( (response.body));
      print(link);
    }}




  signIn(
      String email,
    
      ) async {
    
    Map data = {
      'email':email ,
      
    };
    var jsonResponse = null;
    var response = await http.post(
      "http://grocery.taswog.com/api/reset-emails",
      body: data,
       headers: {
        'Accept-Encoding':'gzip, deflate, br',
         'Accept':'application/json',
       }
    );
    jsonResponse = json.decode(response.body);
    print( jsonResponse);
    if (response.statusCode == 200) {
     return  AlertDialog(
        title: Text('Reset settings?'),
        content: Text('This will reset your device to its default factory settings.'),
        actions: [
          FlatButton(
            textColor: Color(0xFF6200EE),
            onPressed: () {},
            child: Text('CANCEL'),
          ),
          FlatButton(
            textColor: Color(0xFF6200EE),
            onPressed: () {},
            child: Text('ACCEPT'),
          ),
        ],
      );
      // print(jsonResponse['data' ]['token']);
      // print(jsonResponse['data' ]['user' ]['verify']);
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // // var email =   prefs.setString('email', jsonResponse['user' ] [ 'verify'] );
      // // print(email);
      //
      // prefs.setString('data', jsonResponse['data']['token']);

      print(jsonResponse.toString());

      if (jsonResponse != null) {



      } else {
        print(response.body);
      }
    }
  }






  @override
  Widget build(BuildContext context) {
    FocusNode myFocusNode = new FocusNode();
    final TextEditingController emailcontroller = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    Image.asset('assets/Taswog Logo.png'),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Text(
                        'Recovery password',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Text(
                        'Enter your email below to reset your password',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    Container(
                        width: 280,
                        child: TextField(
                          controller: user,
                          decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              // border: OutlineInputBorder(),
                              hintStyle: TextStyle(color: Colors.grey),
                              hintText: ' Username@gmail.com',
                              labelText: ' Email',
                              labelStyle: TextStyle(
                                color: myFocusNode.hasFocus
                                    ? Colors.black
                                    : Colors.black,
                              )),
                        ))
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 140),
                height: 50,
                width: 180,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Colors.orange,
                  child: Text(
                    'Send',
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'Geeza Pro'),
                  ),
                  onPressed: () {
                    signIn(user.text);
                    AwesomeDialog(
                    context: context,
                    animType: AnimType.LEFTSLIDE,
                    headerAnimationLoop: false,
                    dialogType: DialogType.SUCCES ,

                    tittle: 'Succes',
                    desc:
                    'Dialog description here..................................................',
                    btnOkOnPress: () {
                    debugPrint('OnClcik');
                    },
                    btnOkIcon: Icons.check_circle,
                    onDissmissCallback: (type) {
                    debugPrint('Dialog Dissmiss from callback $type');
                    })
                    ..show();
                   if(user.text.isEmpty){
                     return  AwesomeDialog(
                         context: context,
                         dialogType: DialogType.ERROR,
                         animType: AnimType.RIGHSLIDE,
                         headerAnimationLoop: true,
                         tittle: 'Error',
                         desc:
                         'Dialog description here..................................................',
                         btnOkOnPress: () {},
                         btnOkIcon: Icons.cancel,
                         btnOkColor: Colors.red)
                       ..show();


                   }
     },

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
