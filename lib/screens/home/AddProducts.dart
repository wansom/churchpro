import 'dart:io';

import 'package:churchpro/services/auth/auth_service.dart';
import 'package:churchpro/shared/constansts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProducts extends StatefulWidget {
  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  //instance of AuthService
  AuthService _auth = AuthService();
  File sampleImage;
  String productname = '';
  String productprice = '';
  bool isfavorite = false;
  bool isfeatured = false;
  String selectedsupermarket;
  List<String> listedsupermarkets = [
    'naivas',
    'uchumi',
    'nakumatt',
    'quickmatt',
    'shoprite',
    'tuskys',
    'carrefour'
  ];
  //String _currentSugars;

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
      appBar: new AppBar(
        title: new Text('Image Upload'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.person), onPressed: _auth.signOut),
        ],
      ),
      body: new SafeArea(
        child: sampleImage == null ? addProducts() : enableUpload(),
      ),
    );
  }

  Widget addProducts() {
    return ListView(
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
                onChanged: (val) => setState(() => selectedsupermarket = val),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                decoration: decoration.copyWith(labelText: 'product name'),
                onChanged: (value) {
                  setState(() {
                    productname = value;
                  });
                },
              ),
              SizedBox(height: 5.0),
              TextFormField(
                decoration: decoration.copyWith(labelText: 'Price'),
                onChanged: (value) {
                  setState(() {
                    productprice = value;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('Select Image'),
                  IconButton(
                    icon: Icon(Icons.image),
                    onPressed: getImage,
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget enableUpload() {
    return Container(
      child: Column(
        children: <Widget>[
          Image.file(sampleImage, height: 300.0, width: 300.0),
          Text(productname),
          Text(productprice),
          Text(selectedsupermarket),
          RaisedButton(
              elevation: 7.0,
              child: Text('Upload'),
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () async {
                final StorageReference firebaseStorageRef =
                    FirebaseStorage.instance.ref().child(productname);
                final StorageTaskSnapshot snapshot =
                    await firebaseStorageRef.putFile(sampleImage).onComplete;
                if (snapshot.error == null) {
                  final String downloadUrl =
                      await snapshot.ref.getDownloadURL();
                  Firestore.instance.collection('products').add({
                    "imageurl": downloadUrl,
                    "productname": productname,
                    'productprice': productprice,
                    'isfavorite': isfavorite,
                    'isfeatured': isfeatured,
                    'supermarkert': selectedsupermarket,
                  });
                }
              }),
        ],
      ),
    );
  }
}
