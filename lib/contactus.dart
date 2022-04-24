import 'package:flutter/material.dart';



class contactus extends StatefulWidget {
  @override
  _contactusState createState() => _contactusState();
}

class _contactusState extends State<contactus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.keyboard_backspace),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          IconButton(
              iconSize: 20,
              color: Colors.black,
              icon: Icon(Icons.shopping_cart),
              onPressed: () async {}),
        ],
        title: Center(
            child: Text(' Contact us   ',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'sans-serif-condensed'))),
      ),

      body:
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(

                child: Column(


                children: [
                Text( 'contact our customer care center'),
                SizedBox(height: 5,),
                Text('1234556789'),
                  Container(
                    margin: EdgeInsets.only(top:  20),
                    height: 50,
                    width: 180,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular( 5)),
                      color: Colors.orange,
                      child: Text(
                        'Contact us',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Geeza Pro'),
                      ),
                      onPressed: () {

                      },
                    ),
                  ),
              ],
        )),
            ),
          ),

    );
  }
}




