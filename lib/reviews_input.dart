import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:taswag/provider.dart';

class review_input extends StatefulWidget {
  final productid;

  const review_input({Key key, this.productid}) : super(key: key);

  @override
  _review_inputState createState() => _review_inputState();
}

class _review_inputState extends State<review_input> {
  final TextEditingController review = TextEditingController();

  postreview(String review) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('data');
    print(token);
    var authorizations = await http.post(
      'http://grocery.taswog.com/api/product/'
      '${widget.productid} '
      '/reviews',
      body: {
        'review': review,
        'star': '  ${_ratingValue.round()}  ',
      },
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

  double _ratingValue;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EligiblityScreenProvider>(
        create: (context) => EligiblityScreenProvider(),
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.orange,
              actions: [
                Consumer<EligiblityScreenProvider>(
                    builder: (context, provider, child) {
                  return FlatButton(
                      onPressed: () {
                        postreview(review.text);
                        review.clear();
                        provider.eligibleForLicense();
                      },
                      child: Text(
                        'post',
                        style: TextStyle(color: Colors.white),
                      ));
                })
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 120),
                child: Column(
                  children: [
                    Image.asset('assets/Taswog Logo.png'),
                    RatingBar(
                        initialRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        ratingWidget: RatingWidget(
                            full: Icon(Icons.star, color: Colors.orange),
                            half: Icon(
                              Icons.star_half,
                              color: Colors.orange,
                            ),
                            empty: Icon(
                              Icons.star_border,
                              color: Colors.orange,
                            )),
                        onRatingUpdate: (value) {
                          setState(() {
                            _ratingValue = value;
                          });
                        }),
                    SizedBox(height: 25),
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.orange, shape: BoxShape.circle),
                      alignment: Alignment.center,
                      child: Text(
                        _ratingValue != null
                            ? _ratingValue.toString()
                            : 'Rate it!',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: review,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.add_comment,
                              color: Colors.grey,
                            ),
                            prefixStyle: TextStyle(color: Colors.grey),
                            hintText: 'Reviews',
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
                    Positioned(left: 20, child: Text('tell us more optional')),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
