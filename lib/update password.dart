// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import 'package:shared_preferences/shared_preferences.dart';
//
//
//
//
//     class Updatee_password extends StatefulWidget {
//       @override
//       _Updatee_passwordState createState() => _Updatee_passwordState();
//     }
//
//     class _Updatee_passwordState extends State<Updatee_password> {
//       @override
//       Widget build(BuildContext context) {
//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.white,
//             title: Center(
//               child: Text(
//                 'Profile Details',
//                 style: TextStyle(color: Colors.black),
//               ),
//             ),
//             leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: null),
//           ),
//           body: Column(
//
//
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Center(child: Container(
//                     child: Column(
//                       children: [
//                         Image.asset( 'assets/woman .png'),
//                         Text('Change your profile picture',style: TextStyle(color: Colors.grey,fontSize: 10),),
//                       ],
//                     )
//                 )  ,
//
//                 ),
//
//               ),
//               Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: TextFormField (
//                       controller: usernamed   ,
//
//                       decoration: InputDecoration(
//                         focusColor: Colors.grey,
//                         icon: Icon(Icons. person),
//                         hintText: 'username',
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: TextFormField(
//                       controller:  email,
//
//                       decoration: InputDecoration(
//                         focusColor: Colors.grey,
//                         icon: Icon(Icons. phone),
//                         hintText: 'phone  no',
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: TextFormField(
//
//                       obscureText: true,
//                       initialValue: '${widget.userpass}  ',
//                       decoration: InputDecoration(
//                         focusColor: Colors.grey,
//                         icon: Icon(Icons. lock),
//                         hintText: 'password',
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//
//               Container(
//                 margin: EdgeInsets.only(top: 120),
//                 height: 50,
//                 width: 220,
//                 child: MaterialButton(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   color: Colors.orange,
//                   child: Text(
//                     'Update',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: 'Geeza Pro'),
//                   ),
//                   onPressed: () {
//                     Getdetails(   email.text,usernamed.text  );
//
//                   },
//                 ),
//               ),
//             ],
//           ),
//
//         );
//       }
//     }
