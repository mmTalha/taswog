import 'package:flutter/material.dart';



class emptycart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Center(
                child: Text(
                  'cart',
                  style: TextStyle(color: Colors.black),
                )),
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
                }),
            actions: [
              IconButton(
                  icon: Icon(Icons.shopping_cart),
                  color: Colors.black,
                  onPressed: () {

                    // setState(() {
                    //   cartitem = getcart();
                    // });
                  }),
            ],
          ),
        body :Center(
                   child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Text('Add items to get started', style: TextStyle(
                          color: Colors.purple,
                           fontWeight: FontWeight.w500,
                          fontSize: 20),),
                       Icon(
                         Icons.shopping_cart, size: 55, color: Colors.orange,)
                     ],
                   ),
                 ));
  }
}
