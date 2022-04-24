import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:taswag/details.dart';
import 'package:taswag/productDetails.dart';

// class horizontal_list  extends StatefulWidget {
//   @override
//   _horizontal_listState createState() => _horizontal_listState();
//
//
//  class _horizontal_listState extends State<horizontal_list> {
//
//
// @override
// Widget build(BuildContext context) {
//    return Scaffold(
//    body:   Container(
//      height: 100.0,
//       child:,
//       ListView(
//          scrollDirection: Axis.horizontal,
//         children: [
//           category(
//             image_caption: 'Everyday', image_location: 'assets/everyday.png',),
//          category(
//           image_caption: 'Ariel', image_location: 'assets/Ariel .png',),
//           category(
//            image_caption: 'Pulses', image_location: 'assets/pulses.png',),
//          category(
//             image_caption: 'Dalda', image_location: 'assets/Dalda .png',),
//        category(
//             image_caption: 'Everyday', image_location: 'assets/everyday.png',),
//          category(
//              image_caption: 'Ariel', image_location: 'assets/Ariel .png',),
//             category(
//             image_caption: 'Pulses', image_location: 'assets/pulses.png',),
//         ],
//
//        );
//
//
//   //      body: Container(
//   //     height: 100.0,
//   //     child:,
//   //     ListView(
//   //       scrollDirection: Axis.horizontal,
//   //       children: [
//   //         category(
//   //           image_caption: 'Everyday', image_location: 'assets/everyday.png',),
//   //         category(
//   //           image_caption: 'Ariel', image_location: 'assets/Ariel .png',),
//   //         category(
//   //           image_caption: 'Pulses', image_location: 'assets/pulses.png',),
//   //         category(
//   //           image_caption: 'Dalda', image_location: 'assets/Dalda .png',),
//   //         category(
//   //           image_caption: 'Everyday', image_location: 'assets/everyday.png',),
//   //         category(
//   //           image_caption: 'Ariel', image_location: 'assets/Ariel .png',),
//   //         category(
//   //           image_caption: 'Pulses', image_location: 'assets/pulses.png',),
//   //       ],
//   //
//   //     ),
//   //
//   //
//   //       );
//
//
//
//       // FutureBuilder(
//      //     future: getproduct(),
//      //     builder: (context, snapshot) {
//      //       if (!snapshot.hasData) {
//      //         return Center(child: CircularProgressIndicator());
//      //       } else {
//      //         print(' link${snapshot.data}   ');
//      //       }
//      //
//      //       return
//      //          ListView.builder(
//      //
//      //               scrollDirection: Axis.horizontal,
//      //               padding: EdgeInsets.all(8),
//      //               itemCount: snapshot.data.length,
//      //               itemBuilder: (BuildContext context, int index) {
//      //                 return     ListView(
//      //                          scrollDirection: Axis.horizontal,
//      //                           children: [
//      //                            category(image_caption: '${snapshot.data[index]['product_name']}  ',image_location:'assets/everyday.png' ,),
//      //
//      //                         ],
//      //
//      //                         );
//      //
//      //
//      //
//      //               }
//      //
//      //         ),
//      //       );
//      //     }),
//
//
//
//     // Container(
//     // height: 100.0,
//     // child:,
//     // ListView(
//     //   scrollDirection: Axis.horizontal,
//     //   children: [
//     //     category(
//     //       image_caption: 'Everyday', image_location: 'assets/everyday.png',),
//     //     category(
//     //       image_caption: 'Ariel', image_location: 'assets/Ariel .png',),
//     //     category(
//     //       image_caption: 'Pulses', image_location: 'assets/pulses.png',),
//     //     category(
//     //       image_caption: 'Dalda', image_location: 'assets/Dalda .png',),
//     //     category(
//     //       image_caption: 'Everyday', image_location: 'assets/everyday.png',),
//     //     category(
//     //       image_caption: 'Ariel', image_location: 'assets/Ariel .png',),
//     //     category(
//     //       image_caption: 'Pulses', image_location: 'assets/pulses.png',),
//     //   ],
//     //
//     // ),
//     //
//     //
//     // );
//    );}
// }
//   }
// }
class category extends StatelessWidget {
  final String image_location;
  final String image_caption;
  Function ontap;

  category({this.image_location, this.image_caption, this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: InkWell(
        onTap: ontap,
        child: Container(
          width: 100.0,
          child: ListTile(
            title: Image.asset(
              image_location,
              height: 80.0,
              width: 100.0,
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

class horizontal_list extends StatefulWidget {
  @override
  _horizontal_listState createState() => _horizontal_listState();
}

class _horizontal_listState extends State<horizontal_list> {
  Future getproduct() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('data');
    print(token);

    var authorizations = await http.get(
      'http://grocery.taswog.com/api/get-all-products',
      headers: {
        "Authorization": "Bearer $token",
        'Content-Type': 'application/json'
      },
    );
    var responseJson = await json.decode(authorizations.body);
    List data = responseJson['data'];
    var product = data;
    return product;
  }

  void initState() {
    super.initState();
    getproduct();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100.0,
        child: FutureBuilder(
            future: getproduct(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                print(' link${snapshot.data}   ');
              }
              return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index)
                   {

                    return category(
                      ontap: () {
                        print( '${snapshot.data  [index]['product_name']}');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => productdetails(
                                prductname:
                                    '${snapshot.data[index]['product_name']},',
                                price: ' ${snapshot.data[index]['Price']}',
                                productid:
                                    '${snapshot.data[index] ['product_id']} ',

                              ),
                            ));
                      },
                      image_caption: '${snapshot.data[index]['product_name']},'
                          '',
                      image_location: 'assets/everyday.png',
                    );
                  });
            }));
  }
}
