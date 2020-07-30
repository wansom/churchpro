import 'package:barcode_scan/barcode_scan.dart';
import 'package:churchpro/services/database/cart_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class ScanProduct extends StatefulWidget {
  @override
  _ScanProductState createState() => _ScanProductState();
}

class _ScanProductState extends State<ScanProduct> {
  var resultName = 'Please refresh & scan again';
  var resultCode = '03600291452';
  var resultPrice = '0';
  var resultInfo = 'No products match the code scanned';
  var resultImage =
      'https://www.google.com/url?sa=i&url=https%3A%2F%2Ftowardsdatascience.com%2Fa-standalone-application-to-scan-barcode-using-webcam-e09e44d9dbb&psig=AOvVaw2GmzCBDPLUzwTyQGqAqus-&ust=1596176210252000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCIDg2JCq9OoCFQAAAAAdAAAAABAt';
  var netPrice = 0.0;
  var quantity = 1;
  int quant = 1;
  int sum = 0;
  bool notScanned = true;
  void toggleView() {
    setState(() {
      notScanned = !notScanned;
    });
  }

  ScanResult barcode;
  CartService cartServiceInstance = CartService();
  @override
  build(BuildContext context) {
    myText() {
      if (barcode != null) {
        return ListView(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(Icons.menu, color: Colors.black),
                    Stack(children: [
                      Container(
                          height: 45.0, width: 45.0, color: Colors.transparent),
                      Container(
                          height: 40.0,
                          width: 40.0,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: Color(0xFFFE7D6A).withOpacity(0.3),
                                blurRadius: 6.0,
                                spreadRadius: 4.0,
                                offset: Offset(0.0, 4.0))
                          ], color: Color(0xFFFE7D6A), shape: BoxShape.circle),
                          child: Center(
                            child: IconButton(
                                iconSize: 17.0,
                                icon: Icon(Icons.shopping_cart,
                                    color: Colors.white),
                                onPressed: () {}),
                          )),
                      Positioned(
                          top: 1.0,
                          right: 4.0,
                          child: Container(
                              height: 12.0,
                              width: 12.0,
                              decoration: BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              child: Center(
                                child: Text('$quant',
                                    style: GoogleFonts.notoSans(
                                        fontSize: 7.0,
                                        textStyle:
                                            TextStyle(color: Colors.red))),
                              )))
                    ])
                  ],
                )),
            SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                resultName,
                style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w800, fontSize: 27.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
            ),
            SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    height: 200.0,
                    width: 200.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(resultImage),
                            fit: BoxFit.contain))),
                SizedBox(width: 15.0),
                Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 45.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFFFE7D6A).withOpacity(0.1),
                                    blurRadius: 6.0,
                                    spreadRadius: 6.0,
                                    offset: Offset(5.0, 11.0))
                              ]),
                        ),
                        Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.white),
                            child: Center(
                                child: Icon(Icons.favorite_border,
                                    color: Color(0xFFFE7D6A), size: 25.0)))
                      ],
                    ),
                    SizedBox(height: 35.0),
                    Stack(children: <Widget>[
                      Container(
                        height: 45.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xFFFE7D6A).withOpacity(0.1),
                                blurRadius: 6.0,
                                spreadRadius: 6.0,
                                offset: Offset(5.0, 11.0)),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: toggleView,
                        child: Container(
                          height: 50.0,
                          width: 50.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Icon(Icons.restore,
                                color: Color(0xFFFE7D6A), size: 25.0),
                          ),
                        ),
                      ),
                    ])
                  ],
                )
              ],
            ),
            SizedBox(height: 10.0),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                  height: 70.0,
                  width: MediaQuery.of(context).size.width * (33 / 100),
                  color: Colors.white,
                  child: Center(
                      child: Text(
                    '\$' + (int.parse(resultPrice) * quantity).toString(),
                    style: GoogleFonts.notoSans(
                        fontSize: 30.0,
                        color: Color(0xFF5E6166),
                        fontWeight: FontWeight.w500),
                  ))),
              Container(
                  height: 60.0,
                  width: MediaQuery.of(context).size.width * (67 / 100),
                  decoration: BoxDecoration(
                      color: Color(0xFFFE7D6A),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          height: 40.0,
                          width: 104.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white),
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                  iconSize: 17.0,
                                  icon: Icon(Icons.remove,
                                      color: Color(0xFFFE7D6A)),
                                  onPressed: () {
                                    adjustQuantity('MINUS');
                                  }),
                              Text(
                                quantity.toString(),
                                style: GoogleFonts.notoSans(
                                    fontSize: 14.0,
                                    color: Color(0xFFFE7D6A),
                                    fontWeight: FontWeight.w400),
                              ),
                              IconButton(
                                  iconSize: 17.0,
                                  icon:
                                      Icon(Icons.add, color: Color(0xFFFE7D6A)),
                                  onPressed: () {
                                    adjustQuantity('PLUS');
                                  }),
                            ],
                          )),
                      FlatButton(
                        child: Text(
                          'Add to cart',
                          style: GoogleFonts.notoSans(
                              fontSize: 15.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                        onPressed: () async {
                          var firebaseUser =
                              await FirebaseAuth.instance.currentUser();
                          Firestore.instance.collection('cart').add({
                            'productname': resultName,
                            'productcode': resultCode,
                            'productinfo': resultInfo,
                            'imageurl': resultImage,
                            'productprice': resultPrice,
                            'productowner': firebaseUser.uid,
                          });
                          setState(() {
                            quant++;
                          });
                        },
                      )
                    ],
                  ))
            ]),
          ],
        );
      } else {
        return noScanResult();
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: notScanned ? myText() : noScanResult(),
        ),
      ),
    );
  }

  Future scanMe() async {
    try {
      ScanResult result = await BarcodeScanner.scan();
      setState(() {
        barcode = result;
      });
      //get result of the barcode and show related products
      if (barcode != null) {
        await Firestore.instance
            .collection('products')
            .where('productcode', isEqualTo: barcode.rawContent)
            .getDocuments()
            .then((value) {
          value.documents.forEach((element) {
            setState(() {
              resultName = element.data['productname'] ?? 'no results found';
              resultCode = element.data['productcode'] ?? 'no results found';
              resultPrice = element.data['productprice'] ?? 'no results found';
              resultInfo = element.data['productinfo'] ?? 'no results found';
              resultImage = element.data['imageurl'] ?? '';
            });
          });
        });
      } else {
        await Firestore.instance
            .collection('products')
            .where('productcode', isEqualTo: '03600291452')
            .getDocuments()
            .then((value) {
          value.documents.forEach((element) {
            setState(() {
              resultName = element.data['productname'] ?? 'no results found';
              resultCode = element.data['productcode'] ?? 'no results found';
              resultPrice = element.data['productprice'] ?? 'no results found';
              resultInfo = element.data['productinfo'] ?? 'no results found';
              resultImage = element.data['imageurl'] ?? '';
            });
          });
        });
      }
    } on PlatformException catch (e) {
      print(e);
    } on FormatException {
      setState(() {
        barcode.rawContent = '03600291452';
      });
    }
  }

  adjustQuantity(pressed) {
    switch (pressed) {
      case 'PLUS':
        setState(() {
          quantity += 1;
        });
        return;
      case 'MINUS':
        setState(() {
          if (quantity != 0) {
            quantity -= 1;
          }
        });
    }
  }

  noScanResult() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        Container(
          height: 225.0,
          color: Color(0xFF20D3D2),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: IconButton(
              icon: Icon(Icons.refresh),
              iconSize: 50.0,
              color: Colors.white,
              onPressed: toggleView,
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
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: 30.0, left: 20.0, right: 20.0, bottom: 10.0),
                  child: Container(
                    width: screenWidth - 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        InkWell(
                          onTap: scanMe,
                          child: Container(
                            height: 80.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Color(0xFF20D3D2),
                            ),
                            child: Center(
                              child: Text(
                                'Scan',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w900,
                                    fontSize: 24.0,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 10.0, top: 5.0),
                  child: Text(
                    'Click the refresh button to see Item details',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                        color: Color(0xFFBBBBBB)),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
