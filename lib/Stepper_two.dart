import 'package:flutter/material.dart';
import 'package:taswag/all_productlist.dart';

class stepper_two extends StatefulWidget {
  final orderid;

  const stepper_two({Key key, this.orderid}) : super(key: key);
  @override
  _stepper_twoState createState() => _stepper_twoState();
}

class _stepper_twoState extends State<stepper_two> {
  bool valuefirst = false;
  bool valuesecond = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Delivery Address',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [IconButton(

              icon: Icon(Icons.add_box),
              onPressed: (){
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            children: [
                             IconButton(icon:    Icon(Icons.remove) , onPressed:  (){}),
                              Text( 'address' ),

                            ],
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(21.0),
                              child: TextField(


                                decoration: InputDecoration(

                                  border: OutlineInputBorder(),
                                  hintText: 'Address',
                                  labelText: 'Address',
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 120),
                            height: 50,
                            width: 220,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              color: Colors.orange,
                              child: Text(
                                'Save',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Geeza Pro'),
                              ),
                              onPressed: () {

                              },
                            ),
                          ),
                        ],
                      );
                    });


              },
            ),
              Text('add new address',style: TextStyle(fontWeight: FontWeight.bold),

            )
            ],
          ),
        ),
        SizedBox(height: 15,),
        Container(
            decoration: new BoxDecoration(


            ),
            width: MediaQuery.of(context).size.width ,
            height: 170 ,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return
                      Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         
                         Container(
                              child: Row(
                               children: [
                                Icon( Icons.home,color: Colors.black,  ),
                               SizedBox(
                                width: 10,
                              ),
                                 Text('Home'),
                                SizedBox(
                                width:  170,
                              ),
                                 Checkbox(


                                   value: this.valuefirst,
                                   onChanged: (bool value) {
                                     setState(() {
                                       this.valuefirst = value;
                                     });
                                   },
                                 ),

                               ],
                          )),

                        SizedBox(height: 5,),
                        Container(
                          child: Text('03132374807'),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          child: Text( 'nazimad near abbasi hospital '),
                        ),
                      ],

                  );
                })),
        Center(
          child: Container(
            margin: EdgeInsets.only(top:220),
            height: 50,
            width: 220,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: Colors.orange,
              child: Text(
                'Place order',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Geeza Pro'),
              ),
              onPressed: () {
               print(widget.orderid);

              },
            ),
          ),
        ),
      ],
    );
  }
}
