import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taswag/ordermodel.dart';

class orderOverview extends StatefulWidget {
  final orderid;
  final ordernum;

  const orderOverview({Key key, this.orderid, this.ordernum}) : super(key: key);

  @override
  _orderOverviewState createState() => _orderOverviewState();
}

class _orderOverviewState extends State<orderOverview> {
     Data data;
   Future    <Article>  getorderdetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('data');
    print(token);

    var authorizations = await http.get(
      'http://grocery.taswog.com/api/order_list/${widget.orderid}',
      headers: {
        'Accept': 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    var responseJson = await json.decode(authorizations.body);
    // List<dynamic> data = responseJson['data'];
    // var product = data;
    // print(product);
    // return product;
    var article = Article.fromJson(responseJson);


    return
      Article.fromJson(responseJson) ;


  }

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
            child: Text('  orders#${widget.orderid} ',
                style: TextStyle(
                    color: Colors.black, fontFamily: 'sans-serif-condensed'))),
      ),
      body: FutureBuilder< Article>(
          future: getorderdetails(),
          builder: (context, snapshot)  {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {

              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    // return
                    // (Text(  '${snapshot.data.totalInfo.customerName }' ));
                    return _buildCard(
                       //    '${snapshot.data[index] ['order_payment_id']}',
                       //    '${snapshot.data [index] [' order_payment_id']}' ,
                       // '${snapshot.data[index] ['number']}' ,
                       //    '${snapshot.data[index]['product_name']}',
                       //    '${snapshot.data[index]['sale_price']}',
                       //    '${snapshot.data[index]['sale_quantity']}',
                       //  '${snapshot.data[index]['total']}',
                       //    '${snapshot.data[index]['discount_id']}',
                       //   '${snapshot.data[index]['order_total']}',
                       //   '${snapshot.data[index] ['total']}',
                      '${snapshot.data.totalInfo.deliveryAddress }',
                      '${snapshot.data .totalInfo.deliveryAddress }' ,
                      '${snapshot.data.totalInfo.number }' ,
                      '${snapshot.data.datae[index].productName}',
                      '${snapshot.data.datae[index].salePrice}',
                      '${snapshot.data.datae[index].saleQuantity  }',
                      '${snapshot.data.datae[index].salePrice }' ,
                      '${snapshot.data.totalInfo.discount}',
                      '${snapshot.data.totalInfo.deliveryCharges}',
                      '${snapshot.data.datae[index].total    }',
                    );
                  });
            }
          }),
    );
  }
}

class category extends StatelessWidget {
  final deleveryaddress;
  final location;
  final phoneno;
  final prductname;
  final productprice;
  final quantity;
  final orderAmount;
  final discount;
  final deliverycharges;
  final totalAmount;

  const category(
      {Key key,
      this.deleveryaddress,
      this.location,
      this.phoneno,
      this.prductname,
      this.productprice,
      this.quantity,
      this.orderAmount,
      this.discount,
      this.deliverycharges,
      this.totalAmount})
      : super(key: key);

  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              deleveryaddress,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(Icons.location_on),
                SizedBox(
                  width: 10,
                ),
                Text(location),
              ],
            ),
            Row(
              children: [
                Icon(Icons.phone),
                SizedBox(
                  width: 10,
                ),
                Text(phoneno),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'orders List',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Image.asset('assets/barkat.png'),
              title: Row(
                children: [
                  Text(prductname),
                  SizedBox(
                    width: 10,
                  ),
                  Text('5kg'),
                ],
              ),
              trailing: Text(productprice),
              subtitle: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(prductname),
                      Row(
                        children: [
                          Container(
                            child: Center(child: Text('quantity')),
                          ),
                          Text(
                            quantity,
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Order Summary',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Order Amount'),
              Text(orderAmount),
            ]),
            SizedBox(
              height: 15,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Discount'),
              Text(discount),
            ]),
            SizedBox(
              height: 15,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Delivery Charges'),
              Text(deliverycharges),
            ]),
            SizedBox(
              height: 25,
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(' Total Amount '),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(totalAmount),
                          Container(
                            height: 30,
                            width: 100,
                            child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                color: Colors.orange,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Delivered',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Geeza Pro'),
                                      ),
                                    ]),
                                onPressed: () async {}),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}

Widget _buildCard(
  String deleveryaddress,
  String location,
  String phoneno,
  String prductname,
  String productprice,
  String quantity,
  String orderAmount,
  String discount,
  String deliverycharges,
  String totalAmount,
) {
  return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Delivery details',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: Colors.orange,
              ),
              SizedBox(
                width: 10,
              ),
              Text(location),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.phone,
                color: Colors.orange,
              ),
              SizedBox(
                width: 10,
              ),
              Text(phoneno),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'orders List',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Image.asset('assets/barkat.png'),
            title: Row(
              children: [
                Text(prductname),
                SizedBox(
                  width: 10,
                ),
                Text('5kg'),
              ],
            ),
            trailing: Text(productprice),
            subtitle: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(prductname),
                    Row(
                      children: [
                        Container(
                          child: Center(child: Text('quantity')),
                        ),
                        Text(
                          quantity,
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Order Summary',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Order Amount'),
            Text(orderAmount),
          ]),
          SizedBox(
            height: 15,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Discount'),
            Text(discount),
          ]),
          SizedBox(
            height: 15,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Delivery Charges'),
            Text(deliverycharges),
          ]),
          SizedBox(
            height: 25,
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(' Total Amount '),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('RS:$totalAmount'),
                        Container(
                          height: 30,
                          width: 100,
                          child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              color: Colors.orange,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Delivered',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Geeza Pro'),
                                    ),
                                  ]),
                              onPressed: () async {}),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ]),
      ));
}
