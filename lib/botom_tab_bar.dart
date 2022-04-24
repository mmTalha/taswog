import 'package:flutter/material.dart';
import 'package:taswag/Notification.dart';
import 'package:taswag/Productscrollview.dart';
import 'package:taswag/categories.dart';
import 'package:taswag/details.dart';
import 'package:taswag/productpage.dart';
import 'package:taswag/whichlist.dart';


class tab_bar extends StatefulWidget {
  @override
  _tab_barState createState() => _tab_barState();
}

class _tab_barState extends State<tab_bar> {
  static const TextStyle optionStyle =
  TextStyle(fontSize: 10, fontWeight: FontWeight.bold);
  List<Map<String, Object>> _pages;

  int _selectedpageindex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page':productpage(),
        'title': 'Categories',
      },
      {
        'page': details(),
        'title': 'Your Favorite',
      },
      {
        'page': categories(),
        'title': 'categories',
      },
      {
        'page': notification(),
        'title': 'notification',
      },
      {
        'page': whichlist(),
        'title': 'whichlist',
      },

    ];
    super.initState();
  }

  void Selectpaage(int index) {
    setState(() {
      _selectedpageindex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[ _selectedpageindex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Color(0xFFF434A50),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        onTap: Selectpaage,
        currentIndex: _selectedpageindex,

        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.orange,
            title: Text(
              'Store',
              style: optionStyle,
            ),
            icon: Icon(Icons.add_shopping_cart,size: 20,     ),
          ),
          BottomNavigationBarItem(
            title: Text(
              'Details',
              style: optionStyle,
            ),
            icon: Icon(
              Icons.perm_identity,

              size: 20,
            ),
          ),
          BottomNavigationBarItem(
            title: Text(
              'Categories',
              style: optionStyle,
            ),
            icon: Icon(
              Icons.menu,

              size:20,
            ),
          ),
          BottomNavigationBarItem(
            title: Text(
              'notification',
              style: optionStyle,
            ),
            icon: Icon(
              Icons.notifications_none,

              size: 20,
            ),
          ),
          BottomNavigationBarItem(
            title: Text(
              'wishlist',
              style: optionStyle,
            ),
            icon: Icon(
              Icons.favorite_border,
             
              size: 20,
            ),
          )
        ],
      ),







    );
  }
}
