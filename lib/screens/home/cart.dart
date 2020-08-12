import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:provider/provider.dart';
import 'package:scanpay/screens/loading.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  double rating = 5.0;
  String userPhone = '';
  double amount = 1.0;

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              height: 225.0,
              color: Colors.green,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/');
                  },
                ),
              ),
            ),
            Positioned(
              top: 100.0,
              child: Container(
                height: screenHeight - 190.0,
                width: screenWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
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
                                                    color: Colors.green,
                                                  ),
                                                  child: Center(
                                                    child: Image.asset(
                                                        products['imageurl'],
                                                        height: 50.0,
                                                        width: 50.0),
                                                  ),
                                                ),
                                                SizedBox(width: 20.0),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                        products['productname'],
                                                        style: GoogleFonts
                                                            .notoSans(
                                                                fontSize: 14.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                    SmoothStarRating(
                                                        allowHalfRating: false,
                                                        onRated: (v) {},
                                                        starCount:
                                                            rating.toInt(),
                                                        rating: rating,
                                                        color: Colors.green,
                                                        borderColor:
                                                            Colors.green,
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
                                                                  FontWeight
                                                                      .w600,
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
                                                                  FontWeight
                                                                      .w600,
                                                              textStyle: TextStyle(
                                                                  color: Colors
                                                                      .grey
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
                                            onPressed: () async {
                                              await Firestore.instance
                                                  .collection('cart')
                                                  .document(products.documentID)
                                                  .delete()
                                                  .then((value) => null);
                                            },
                                            child: Center(
                                                child: Icon(Icons.remove,
                                                    color: Colors.white)),
                                            backgroundColor: Colors.green,
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
            ),
            Positioned(
              top: screenHeight - 200.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 85.0),
                child: Container(
                  height: 40.0,
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.green,
                            style: BorderStyle.solid,
                            width: 1.0),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: FlatButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: MediaQuery.of(context).size.height,
                                child: ListView(
                                  children: <Widget>[
                                    Stack(
                                      children: <Widget>[
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    15.0, 100.0, 0.0, 0.0),
                                                child: Text(
                                                  'Lipa Na Mpesa',
                                                  style: TextStyle(
                                                      fontSize: 40.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    273.0, 80.0, 0.0, 0.0),
                                                child: Text(
                                                  '.',
                                                  style: TextStyle(
                                                      fontSize: 80.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.green),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0.0, 190.0, 0.0, 0.0),
                                          child: Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 35.0,
                                                  left: 20.0,
                                                  right: 20.0),
                                              child: Form(
                                                autovalidate: true,
                                                key: _formkey,
                                                child: Column(
                                                  children: <Widget>[
                                                    TextFormField(
                                                      keyboardType: TextInputType
                                                          .numberWithOptions(),
                                                      decoration: InputDecoration(
                                                          labelText:
                                                              'Enter phone no',
                                                          hintText:
                                                              '254705122230'),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          userPhone = value;
                                                        });
                                                      },
                                                    ),

                                                    // TextFormField(
                                                    //   decoration: InputDecoration(
                                                    //       labelText: 'Amount'),
                                                    //   onChanged: (value) {
                                                    //     setState(() {
                                                    //       amount =
                                                    //           double.parse(value);
                                                    //     });
                                                    //   },
                                                    // ),
                                                    SizedBox(
                                                      height: 20.0,
                                                    ),
                                                    Container(
                                                      height: 40.0,
                                                      child: Material(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        shadowColor:
                                                            Colors.greenAccent,
                                                        color: Colors.green,
                                                        elevation: 7.0,
                                                        child: FlatButton(
                                                          onPressed:
                                                              startCheckout,
                                                          child: Center(
                                                            child: Text(
                                                              'Pay Now',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      'Montserrat'),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      child: Center(
                        child: Text(
                          'Proceed to Checkout ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> startCheckout() async {
    Navigator.pop(context);
    //Preferably expect 'dynamic', response type varies a lot!
    dynamic transactionInitialisation;
    //Better wrap in a try-catch for lots of reasons.
    try {
      //Run it
      transactionInitialisation = await MpesaFlutterPlugin.initializeMpesaSTKPush(
          businessShortCode: "174379",
          transactionType: TransactionType.CustomerPayBillOnline,
          amount: amount,
          partyA: userPhone,
          partyB: "174379",
          callBackURL: Uri(
              scheme: "https", host: "my-app.herokuapp.com", path: "/callback"),
          accountReference: "Scanpay",
          phoneNumber: userPhone,
          baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
          transactionDesc: "purchase",
          passKey:
              "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919");

      print("TRANSACTION RESULT: " + transactionInitialisation.toString());

      /*Update your db with the init data received from initialization response,
      * Remaining bit will be sent via callback url*/
      return transactionInitialisation;
    } catch (e) {
      //For now, console might be useful
      print("CAUGHT EXCEPTION: " + e.toString());
    }
  }
}
