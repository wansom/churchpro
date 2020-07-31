import 'package:churchpro/screens/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  double rating = 5.0;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          height: 225.0,
          color: Color(0xFF20D3D2),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        Positioned(
          top: 190.0,
          child: Container(
            height: screenHeight - 190.0,
            width: screenWidth,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0))),
            child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection('cart')
                    .where('productowner', isEqualTo: user.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var mysnapshot = snapshot.data;
                    return Padding(
                      padding: EdgeInsets.only(
                          top: 10.0, left: 0.0, right: 0.0, bottom: 10.0),
                      child: Container(
                        width: screenWidth - 40.0,
                        child: ListView.builder(
                            itemCount: mysnapshot.documents.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot products =
                                  mysnapshot.documents[index];
                              return Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                          width: 210.0,
                                          child: Row(children: [
                                            Container(
                                                height: 75.0,
                                                width: 75.0,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7.0),
                                                    color: Color(0xFFFFE3DF)),
                                                child: Center(
                                                    child: Image.asset(
                                                        products['imageurl'],
                                                        height: 50.0,
                                                        width: 50.0))),
                                            SizedBox(width: 20.0),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(products['productname'],
                                                    style: GoogleFonts.notoSans(
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                                SmoothStarRating(
                                                    allowHalfRating: false,
                                                    onRated: (v) {},
                                                    starCount: rating.toInt(),
                                                    rating: rating,
                                                    color: Color(0xFFFFD143),
                                                    borderColor:
                                                        Color(0xFFFFD143),
                                                    size: 15.0,
                                                    spacing: 0.0),
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                      '\$' +
                                                          products[
                                                              'productprice'],
                                                      style: GoogleFonts.lato(
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          textStyle: TextStyle(
                                                              color: Color(
                                                                  0xFFF68D7F))),
                                                    ),
                                                    SizedBox(width: 3.0),
                                                    Text(
                                                      '\$' + '18',
                                                      style: GoogleFonts.lato(
                                                          fontSize: 12.0,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          textStyle: TextStyle(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.4))),
                                                    )
                                                  ],
                                                )
                                              ],
                                            )
                                          ])),
                                      FloatingActionButton(
                                        heroTag: products['productname'],
                                        mini: true,
                                        onPressed: () {},
                                        child: Center(
                                            child: Icon(Icons.remove,
                                                color: Colors.white)),
                                        backgroundColor: Color(0xFFFE7D6A),
                                      )
                                    ],
                                  ));
                            }),
                      ),
                    );
                  } else {
                    return Loading();
                  }
                }),
          ),
        )
      ],
    ));
  }
}
