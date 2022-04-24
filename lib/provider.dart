import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EligiblityScreenProvider extends ChangeNotifier{
  String _eligiblityMessage = "";
  bool _isEligible;

  void checkEligiblity(int age){
    if(age >= 18)
      eligibleForLicense();
    else
      notEligibleForLicense();
  }

  Future getadressid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('data');
    print(token);

    var authorizations = await http.get(
      'http://grocery.taswog.com/api/get-delivery-address',
      headers: {
        'Accept': 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    var responseJson = await json.decode(authorizations.body);
    List data = responseJson['addresses'];
    var product = data;
    notifyListeners();
    return product;
  }
  void eligibleForLicense(){
    _eligiblityMessage = "You are eligible to apply for Driving License";
    _isEligible = true;

    //Call this whenever there is some change in any field of change notifier.
    notifyListeners();
  }


  void notEligibleForLicense(){
    _eligiblityMessage = "You are not eligible to apply for Driving License";
    _isEligible = false;

    //Call this whenever there is some change in any field of change notifier.
    notifyListeners();
  }
  Future deletewishlist() async {
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('data');
    print(token);
    var authorizations = await http.delete(
      'http://grocery.taswog.com/api/delete-wishList',
      headers: {
        'Accept': 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    var responseJson = await json.decode(authorizations.body);
     var data = responseJson['message'] ;

    var product = data;
    print(product);

    return product;

  }
  Future deletecart() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('data');
    print(token);
    var authorizations = await http.delete(
      'http://grocery.taswog.com/api/delete-cart',
      headers: {
        'Accept': 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    var responseJson = await json.decode(authorizations.body);
    var data = responseJson['message'] ;

    var product = data;
    print(product);
    notifyListeners();
   return product;

  }
  Future wishlistitemdelt(int e) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('data');
    print(token);
    var authorizations = await http.delete(
      'http://grocery.taswog.com/api/delete-wishListItem/$e',
      headers: {
        'Accept': 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    var responseJson = await json.decode(authorizations.body);
    var data = responseJson['message'] ;

    var product = data;
    print(product);
    notifyListeners();
    return product;

  }


  //Getter for Eligiblity message
  String get eligiblityMessage => _eligiblityMessage;

  //Getter for Eligiblity flag
  bool get isEligible => _isEligible;


}