import 'package:churchpro/screens/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Food extends StatefulWidget {
  // final ValueSetter<Products> _valueSetter;

  // Food(this._valueSetter);
  @override
  _FoodState createState() => _FoodState();
}

class _FoodState extends State<Food> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('products')
            .where('category', isEqualTo: 'food')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var mysnapshot = snapshot.data;
            return Container(
              padding: EdgeInsets.only(right: 15.0),
              width: MediaQuery.of(context).size.width - 30.0,
              height: MediaQuery.of(context).size.height * (60 / 100),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: mysnapshot.documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot products = mysnapshot.documents[index];
                    return Padding(
                        padding: EdgeInsets.only(
                            top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
                        child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/productdetails',
                                  arguments: ({
                                    'selectedName': products['productname'],
                                    'selectedPrice': products['productprice'],
                                    'selectedImage': products['imageurl'],
                                    'selectedInfo': products['productinfo'],
                                    'selectedSupermarket':
                                        products['supermarkert'],
                                  }));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            products['isfavorite']
                                                ? Icon(Icons.favorite,
                                                    color: Color(0xFFFE7D6A))
                                                : Icon(Icons.favorite_border,
                                                    color: Color(0xFFFE7D6A))
                                          ])),
                                  Container(
                                      height: 38.0,
                                      width: 75.0,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  products['imageurl']),
                                              fit: BoxFit.contain))),
                                  SizedBox(height: 3.0),
                                  Text('${products["productprice"]}',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontFamily: 'Varela',
                                          fontSize: 14.0)),
                                  Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Container(
                                          color: Colors.green, height: 1.0)),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 5.0, right: 5.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            if (!products['isfeatured']) ...[
                                              Icon(Icons.shopping_basket,
                                                  color: Colors.green,
                                                  size: 12.0),
                                              Text('Add to cart',
                                                  style: TextStyle(
                                                      fontFamily: 'Varela',
                                                      color: Colors.green,
                                                      fontSize: 12.0))
                                            ],
                                            if (products['isfeatured']) ...[
                                              Icon(Icons.remove_circle_outline,
                                                  color: Colors.green,
                                                  size: 12.0),
                                              Text('3',
                                                  style: TextStyle(
                                                      fontFamily: 'Varela',
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12.0)),
                                              Icon(Icons.add_circle_outline,
                                                  color: Colors.green,
                                                  size: 12.0),
                                            ]
                                          ]))
                                ]))));
                  }),
            );
          } else {
            return Loading();
          }
        });
  }
}
