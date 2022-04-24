
import 'package:flutter/material.dart';
import 'package:taswag/botom_tab_bar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';




 class profliledetails extends StatefulWidget {
   var username;
   final useremail   ;
   final userpass;

  profliledetails({Key key, this.username, this.useremail,this.userpass}) : super(key: key);
   @override
   _profliledetailsState createState() => _profliledetailsState();
 }

 class _profliledetailsState extends State<profliledetails> {
     TextEditingController email = TextEditingController();
     TextEditingController usernamed = TextEditingController();
     TextEditingController newpassword  = TextEditingController();

     TextEditingController password  = TextEditingController();

   @override
   void initState() {
     super.initState();
     email = TextEditingController(text:  '${  widget.useremail  }');
     usernamed = TextEditingController(text: '${ widget.username }');
     password = TextEditingController(text: '${ widget.userpass }');
   }

   bool _isLoading = false;

   // final TextEditingController email =  TextEditingController();
   //
   //
   // final TextEditingController username = TextEditingController();

   Future   Getdetails(
       String name,
     String num,
      pass,
      newpass,


       ) async {
     try{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     var token = prefs.getString('data');
     print(token);
     Map data = {
       'name': num,
       'contact': name,
       'old_password':pass,
       'new_password':newpass,
     };
     var authorizations = await http.put(
       'http://grocery.taswog.com/api/update-details',
       body: data,
       headers: {
         'Accept': 'application/json',
         "Authorization": "Bearer $token",
       },
     );
     var responseJson = await json.decode(authorizations.body);
     var iddata = responseJson[ "User" ];
     var product = iddata ;
     print( product );
     return product;
     }catch(e) {
       print(e.toString());

     }

   }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.white,
         title: Center(
           child: Text(
             'Profile Details',
             style: TextStyle(color: Colors.black),
           ),
         ),
         leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: null),
       ),
      body: SingleChildScrollView(
        child: Column(


          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Container(
               child: Column(
                 children: [
                   Image.asset( 'assets/woman .png'),
                    Text('Change your profile picture',style: TextStyle(color: Colors.grey,fontSize: 10),),
                 ],
               )
              )  ,

              ),

            ),
            Column(
            children: [
            Padding(
            padding: const EdgeInsets.all(20.0),
               child: TextFormField (
                 controller: usernamed   ,

                          decoration: InputDecoration(
                             focusColor: Colors.grey,
                               icon: Icon(Icons.person) ,
                            hintText: 'username',
                           ),
                             ),
                           ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                 controller:  email,

                  decoration: InputDecoration(
                    focusColor: Colors.grey,
                    icon: Icon(Icons. phone),
                    hintText: 'phone  no',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(

                  obscureText: true,
                   controller: password,

                  decoration: InputDecoration(
                    focusColor: Colors.grey,
                    icon: Icon(Icons. lock),
                    hintText: 'password',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField (
                  controller: newpassword   ,

                  decoration: InputDecoration(
                    focusColor: Colors.grey,
                    icon: Icon(Icons. person),
                    hintText: 'new password',
                  ),
                ),
              ),

            ],
            ),

            Container(
              margin: EdgeInsets.only(top: 120),
              height: 50,
              width: 220,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Colors.orange,
                child: Text(
                  'Update',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Geeza Pro'),
                ),
                onPressed: () {
                  Getdetails(   email.text,usernamed.text,password.text,newpassword.text  );

                },
              ),
            ),
          ],
        ),
      ),

     );
   }
 }
