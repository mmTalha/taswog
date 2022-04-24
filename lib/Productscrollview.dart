import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:taswag/productDetails.dart';

class Productscroolview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Container(
                    height: 60,
                    width: 100,
                    child: Image.asset('assets/rashan1.png'),
                  ),
                  Text('package2'),
                  SizedBox(
                    height: 10,
                  ),
                  Text('PKR'),
                  Text('300'),
                  Container(
                    height: 35,
                    margin: EdgeInsets.only(
                      left: 70,
                    ),
                    child: Hero(
                      tag: 'col',
                      child: IconButton(
                          color: Colors.orange,
                          iconSize: 30,
                          icon: Icon(Icons.add_box),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder:  (context)=> productdetails()));
                          }),
                    ),
                  ),
                ],
              ),
              Card('Package2', 'pkr', '300 ', 'assets/rashan1.png'),
              Card('package2', 'PKR', '300', 'assets/rashan1.png'),
              Card('package2', 'PKR', '300', 'assets/rashan1.png'),
              Card('package2', 'PKR', '300', 'assets/rashan1.png'),
              Card('package2', 'PKR', '300', 'assets/rashan1.png'),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 30, top: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Top Products',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Times New Roman',
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 25,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Card('Surf Excel', 'pkr', '300 ', 'assets/Ariel .png'),
              Card('Dalda Cooking oil', 'pkr', '300 ', 'assets/Dalda .png'),
              Card('Everyday', 'pkr', '300 ', 'assets/everyday.png'),
              Card('Surf Excel', 'pkr', '300 ', 'assets/Ariel .png'),
              Card('Dalda Cooking oil', 'pkr', '300 ', 'assets/Dalda .png'),
              Card('Everyday', 'pkr', '300 ', 'assets/everyday.png'),
              Card('Package2', 'pkr', '300 ', 'assets/rashan1.png'),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 40,
              ),
              child: Text(
                'Groceries',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
            FlatButton(
                onPressed: () {},
                child: Text(
                  'see all',
                  style: TextStyle(color: Colors.grey),
                ))
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 50,
              width: 120,
              color: Colors.orangeAccent,
              child: Row(
                children: [
                  Image.asset('assets/pulses.png'),
                  Text(
                    'Pulses',
                    style: TextStyle(fontSize: 20, fontFamily: 'sans-serif'),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              width: 120,
              color: Color.fromRGBO(83, 177, 117, 1),
              child: Row(
                children: [
                  Image.asset('assets/grocery.png'),
                  Text(
                    'Rice',
                    style: TextStyle(fontSize: 20, fontFamily: 'sans-serif'),
                  ),
                ],
              ),
            ),
          ],
        ),
         SizedBox(height: 20,),
         SingleChildScrollView(
           scrollDirection: Axis.horizontal,
           child: Row(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Card( 'Productname',  'PKR',  '25',  'assets/knorr.png'),
              Card( 'Productname',  'PKR',  '250',  'assets/national.png'),
               Card( 'Productname',  'PKR',  '150',  'assets/knorr.png'),
             ],
           ),
         )
      ],
    );
  }
}

Widget _buildCard(
  String name,
  String price,
  String imgPath,
  String package,
) {
  return InkWell(
      onTap: () {},
      child: Container(
          height: 180,
          width: 110,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3.0,
                    blurRadius: 5.0)
              ],
              color: Colors.white),
          child: Column(children: [
            Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end, children: [])),
            Container(
                height: 75.0,
                width: 75.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(imgPath), fit: BoxFit.cover))),
            SizedBox(height: 7.0),
            Text(price,
                style: TextStyle(
                    color: Color(0xFFCC8053),
                    fontFamily: 'Varela',
                    fontSize: 14.0)),
            Text(name,
                style: TextStyle(
                    color: Color(0xFF575E67),
                    fontFamily: 'Varela',
                    fontSize: 14.0)),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(color: Color(0xFFEBEBEB), height: 1.0)),
            Padding(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.add, color: Color(0xFFD17E50), size: 12.0),
                    Text(package,
                        style: TextStyle(
                            fontFamily: 'Varela',
                            color: Color(0xFFD17E50),
                            fontSize: 12.0))
                  ],
                ))
          ])));
}

Widget Card(
  String package,
  String pkr,
  String rps,
  String img,
) {
  return Column(
    children: [
      Container(
          height: 60,
          width: 100,
          child: Image.asset(
            img,
          )),
      Text(package),
      SizedBox(
        height: 10,
      ),
      Text(pkr),
      Text(rps),
      Container(
        height: 35,
        margin: EdgeInsets.only(
          left: 70,
        ),
        child: IconButton(
            color: Colors.orange,
            iconSize: 30,
            icon: Icon(Icons.add_box),
            onPressed: () {}),
      ),
    ],
  );
}
