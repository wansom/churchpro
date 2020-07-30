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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new SafeArea(
        child: sampleImage == null ? addProducts() : enableUpload(),
      ),
    );
  }

  Widget addProducts() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        Container(
          height: 225.0,
          color: Color(0xFF20D3D2),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {}),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Text(
                'Add Product',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )),
        ),
        Positioned(
          top: 100.0,
          child: Container(
            height: screenHeight - 100.0,
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
                      top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                  child: Container(
                    width: screenWidth - 40.0,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: screenHeight - 100,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Color(0xFF20D3D2),
                          ),
                          child: ListView(
                            children: <Widget>[
                              Form(
                                key: _formkey,
                                child: Column(
                                  children: <Widget>[
                                    DropdownButtonFormField(
                                      value: selectedsupermarket ?? 'naivas',
                                      decoration: decoration,
                                      items: listedsupermarkets.map((sugar) {
                                        return DropdownMenuItem(
                                          value: sugar,
                                          child: Text('$sugar supermarket'),
                                        );
                                      }).toList(),
                                      onChanged: (val) => setState(
                                          () => selectedsupermarket = val),
                                    ),
                                    SizedBox(height: 10.0),
                                    TextFormField(
                                      decoration: decoration.copyWith(
                                          labelText: 'product name'),
                                      onChanged: (value) {
                                        setState(() {
                                          productname = value;
                                        });
                                      },
                                    ),
                                    SizedBox(height: 5.0),
                                    TextFormField(
                                      decoration: decoration.copyWith(
                                          labelText: 'Price'),
                                      onChanged: (value) {
                                        setState(() {
                                          productprice = value;
                                        });
                                      },
                                    ),
                                    TextFormField(
                                      decoration: decoration.copyWith(
                                          labelText: 'Description'),
                                      onChanged: (value) {
                                        setState(() {
                                          productinfo = value;
                                        });
                                      },
                                    ),
                                    DropdownButtonFormField(
                                      value: selectedCategory ?? 'electronics',
                                      decoration: decoration,
                                      items: myCategories.map((sugar) {
                                        return DropdownMenuItem(
                                          value: sugar,
                                          child: Text('$sugar Category'),
                                        );
                                      }).toList(),
                                      onChanged: (val) => setState(
                                          () => selectedCategory = val),
                                    ),
                                    Container(
                                        height: 40.0,
                                        width: 105.0,
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          shadowColor: Colors.greenAccent,
                                          color: Colors.green,
                                          elevation: 7.0,
                                          child: GestureDetector(
                                            onTap: scanMe,
                                            child: Center(
                                              child: Text(
                                                'Scan Code',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )),
                                    SizedBox(height: 5.0),
                                    Container(
                                        height: 40.0,
                                        width: 105.0,
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          shadowColor: Colors.greenAccent,
                                          color: Colors.green,
                                          elevation: 7.0,
                                          child: GestureDetector(
                                            onTap: getImage,
                                            child: Center(
                                              child: Text(
                                                'Select Image',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
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
