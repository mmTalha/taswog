import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:taswag/subcategory.dart';

class categories extends StatefulWidget {
  @override
  _categoriesState createState() => _categoriesState();
}

class _categoriesState extends State<categories> {


var productid;




 Future getcateg()async{

 SharedPreferences prefs = await SharedPreferences.getInstance();
 var token = prefs.getString('data');
 print(token);
 var authorizations = await http.get(
 'http://grocery.taswog.com/api/categories' ,
 headers: {
     'Accept':'application/json',
   "Authorization": "Bearer  $token"
 }
 );
 var responseJsons = await json.decode(authorizations.body);
 var categ_id  = responseJsons  ['category_id']  ;
 print(categ_id);

 return responseJsons[  "data" ]  ;
 }


 void initState() {
   super.initState();
   getcateg();
 }

















  var Product_list = [
  {
  ' name' : 'blazer',
  'picture' : 'assets/grocery.png',
    'colour':     Colors.green[50] ,
    'bgcolor':  Colors.green  ,
  'name2': 'Fresh Food'
},
{
' name' : "Blazer2",
'picture' : 'assets/pulses.png',
'name2': 'Cooking oil',
  'colour':  Colors.orange[50] ,
  'bgcolor':  Colors.orange  ,
},
{' name' : "black shirt",
'picture' : 'assets/grocery.png',
'name2': 'meat',
  'colour':  Colors.pink[50] ,
  'bgcolor':  Colors.pink  ,

},
{' name' : "white  dress",
'picture' : 'assets/pulses.png',
  'bgcolor':  Colors.purple  ,
  'colour':  Colors.purple[50] ,
'name2': 'Breakfast',

},
    {' name' : "white  dress",
      'picture' : 'assets/pulses.png',
      'bgcolor':  Colors.purple  ,
      'colour':  Colors.purple[50] ,
      'name2': 'Breakfast',

    },
    {' name' : "white  dress",
      'picture' : 'assets/pulses.png',
      'bgcolor':  Colors.purple  ,
      'colour':  Colors.purple[50] ,
      'name2': 'Breakfast',

    },
  ];
  @override
  Widget build(BuildContext context) {
    FocusNode myFocusNode = new FocusNode();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
            child: Text(
          'Categories',
          style: TextStyle(color: Colors.black),
        )),
        leading: IconButton(
            icon: Icon(Icons.arrow_back), color: Colors.black, onPressed: null),
        actions: [
          IconButton(
              icon: Icon(Icons.shopping_cart),
              color: Colors.black  ,
              onPressed: null),
        ],
      ),
      body: SingleChildScrollView(
         scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                 decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search,color: Colors.grey,),
                    prefixStyle:   TextStyle(color: Colors.grey) ,
                    hintText: 'Search your category',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.grey)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.red)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.red))),
              ),
            ),

             SizedBox(height: 20,),
            // Container(
            //    height: 100,
            //    width: 120,
            //     decoration: BoxDecoration(
            //       border: Border.all(
            //         color: Colors.green,
            //       ),
            //       color: Colors.green[50],
            //       borderRadius: BorderRadius.circular(15)
            //     ),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Image.asset('assets/grocery.png'),
            //       SizedBox(height: 5,),
            //       Text(
            //         'Rice',
            //         style: TextStyle(
            //             fontSize: 20, fontFamily: 'sans-serif'),
            //       ),
            //     ],
            //   ),

               FutureBuilder(
                   future: getcateg() ,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            print(' link${snapshot.data}   ');
                          }
                          return Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: GridView.builder(

                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                                  crossAxisCount: 2,
                                  childAspectRatio: 1 / 1,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                ),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: (){
                                   var   id =  '${snapshot.data[index]['category_id']}';
                                    print(id);
                                    setState(() {
                                      productid = id;
                                      print(productid);
                                    });
                                   Navigator.push(
                                       context,
                                       PageRouteBuilder(
                                           transitionDuration: Duration(seconds: 2),
                                           pageBuilder:
                                               (context, animation, animationtime) =>
                                               sub_category(),
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
                                           }));
                                    },
                                    child: Container(
                                      height: 120,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Product_list[index]['bgcolor'],
                                          ),
                                          color: Product_list[index]['colour'],
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Image.asset(
                                            Product_list[index]['picture'],),
                                          SizedBox(height: 5,),
                                          Text(
                                              '${snapshot.data[index]['category_name']}',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'sans-serif'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          );

                        }),

                

          ],
        ),
      ),
    );
  }
}
