import 'dart:io';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:churchpro/shared/constansts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AddProducts extends StatefulWidget {
  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  //instance of AuthService

  File sampleImage;
  String productname = '';
  String productprice = '';
  String productinfo = '';
  bool isfavorite = false;
  bool isfeatured = false;
  String selectedsupermarket;
  String barcodeResult = '';
  List<String> listedsupermarkets = [
    'naivas',
    'uchumi',
    'nakumatt',
    'quickmatt',
    'shoprite',
    'tuskys',
    'carrefour'
  ];
  String selectedCategory;
  List<String> myCategories = [
    'electronics',
    'fashion',
    'furniture',
    'food',
    'cutlery',
  ];
  ScanResult barcode;
  final _formkey = GlobalKey<FormState>();

  Future getImage() async {
    // ignore: deprecated_member_use
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage = tempImage;
    });
  }

  String error = '';
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new SafeArea(
        child: sampleImage == null ? addProducts() : enableUpload(),
      ),
    );
  }

  Widget addProducts() {
    // final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
        Widget>[
      Container(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(15.0, 100.0, 0.0, 0.0),
              child: Text(
                'Add Product',
                style: TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(260.0, 115.0, 0.0, 0.0),
              child: Text(
                '.',
                style: TextStyle(
                    fontSize: 80.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            )
          ],
        ),
      ),
      Container(
          padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (value) =>
                      value.isEmpty ? 'field is required' : null,
                  onChanged: (val) {
                    setState(() {
                      productname = val;
                    });
                  },
                  decoration: decoration,
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  validator: (value) =>
                      value.isEmpty ? 'field is required' : null,
                  onChanged: (val) {
                    setState(() {
                      productinfo = val;
                    });
                  },
                  decoration: decoration,
                ),
                TextFormField(
                  validator: (value) =>
                      value.isEmpty ? 'field is required' : null,
                  onChanged: (val) {
                    setState(() {
                      productprice = val;
                    });
                  },
                  decoration: decoration,
                ),
                DropdownButtonFormField(
                  value: selectedsupermarket ?? 'naivas',
                  decoration: decoration,
                  items: listedsupermarkets.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar supermarket'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => selectedsupermarket = val),
                ),
                SizedBox(height: 50.0),
                DropdownButtonFormField(
                  value: selectedCategory ?? 'electronics',
                  decoration: decoration,
                  items: myCategories.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar Category'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => selectedCategory = val),
                ),
                SizedBox(height: 50.0),
                Container(
                    height: 40.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.greenAccent,
                      color: Colors.green,
                      elevation: 7.0,
                      child: RaisedButton(
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            scanMe();
                          } else {}
                        },
                        child: Center(
                          child: Text(
                            'Scan Product',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                      ),
                    )),
                SizedBox(height: 20.0),
                Container(
                  height: 40.0,
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 1.0),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: InkWell(
                        onTap: getImage,
                        child: Center(
                          child: Text('select Image',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat')),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
      SizedBox(height: 5.0),
      Text(
        error,
        style: TextStyle(color: Colors.red),
      )
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: <Widget>[
      //     Text(
      //       'New to Spotify?',
      //       style: TextStyle(
      //         fontFamily: 'Montserrat',
      //       ),
      //     ),
      //     SizedBox(width: 5.0),
      //     InkWell(
      //       child: Text('Register',
      //           style: TextStyle(
      //               color: Colors.green,
      //               fontFamily: 'Montserrat',
      //               fontWeight: FontWeight.bold,
      //               decoration: TextDecoration.underline)),
      //     )
      //   ],
      // )
    ]);
  }

  Widget enableUpload() {
    return Container(
      child: Column(
        children: <Widget>[
          Image.file(sampleImage, height: 300.0, width: 300.0),
          SizedBox(
            height: 3.0,
          ),
          Text(productname),
          SizedBox(
            height: 3.0,
          ),
          Text(productprice),
          SizedBox(
            height: 3.0,
          ),
          Text(selectedsupermarket),
          SizedBox(
            height: 3.0,
          ),
          Text(selectedCategory),
          SizedBox(
            height: 3.0,
          ),
          Text(barcodeResult),
          RaisedButton(
            elevation: 7.0,
            child: Text('Upload'),
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: () async {
              if (barcode != null) {
                setState(() {
                  barcodeResult = barcode.rawContent ?? 'none';
                });
              }
              final StorageReference firebaseStorageRef =
                  FirebaseStorage.instance.ref().child(productname);
              final StorageTaskSnapshot snapshot =
                  await firebaseStorageRef.putFile(sampleImage).onComplete;
              if (snapshot.error == null) {
                final String downloadUrl = await snapshot.ref.getDownloadURL();
                Firestore.instance.collection('products').add({
                  "imageurl": downloadUrl,
                  "productname": productname,
                  'productprice': productprice,
                  'isfavorite': isfavorite,
                  'isfeatured': isfeatured,
                  'supermarkert': selectedsupermarket,
                  'category': selectedCategory,
                  'productcode': barcodeResult,
                  'productinfo': productinfo,
                });
              }
            },
          ),
        ],
      ),
    );
  }

  //scan function
  Future scanMe() async {
    try {
      ScanResult result = await BarcodeScanner.scan();
      setState(() {
        barcode = result;
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
