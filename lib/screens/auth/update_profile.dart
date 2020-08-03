import 'dart:io';

import 'package:churchpro/shared/constansts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _formkey = GlobalKey<FormState>();
  String username = '';
  String useremail = '';
  String imageurl = '';
  String location = '';
  String error = '';
  File sampleImage;
  Future getImage() async {
    // ignore: deprecated_member_use
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage = tempImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 30.0, 0.0, 0.0),
                  child: Text(
                    ' Profile',
                    style:
                        TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(270.0, 32.0, 0.0, 0.0),
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
                          username = val;
                        });
                      },
                      decoration: decoration.copyWith(labelText: 'username'),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      validator: (value) =>
                          value.isEmpty ? 'field is required' : null,
                      onChanged: (val) {
                        setState(() {
                          useremail = val;
                        });
                      },
                      decoration: decoration.copyWith(labelText: 'Description'),
                    ),
                    TextFormField(
                      validator: (value) =>
                          value.isEmpty ? 'field is required' : null,
                      onChanged: (val) {
                        setState(() {
                          location = val;
                        });
                      },
                      decoration: decoration.copyWith(labelText: 'Location'),
                    ),
                    SizedBox(height: 50.0),
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
                        child: FlatButton(
                          onPressed: getImage,
                          child: Center(
                            child: Text('Select Image ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat')),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
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
                          onPressed: () async {
                            FirebaseUser user =
                                await FirebaseAuth.instance.currentUser();
                            final StorageReference firebaseStorageRef =
                                FirebaseStorage.instance.ref().child(username);
                            final StorageTaskSnapshot snapshot =
                                await firebaseStorageRef
                                    .putFile(sampleImage)
                                    .onComplete;
                            if (snapshot.error == null) {
                              final String downloadUrl =
                                  await snapshot.ref.getDownloadURL();
                              Firestore.instance
                                  .collection('users')
                                  .document(user.uid)
                                  .setData({
                                'username': username,
                                'email': useremail,
                                'imageurl': downloadUrl,
                                'location': location,
                              });
                              Navigator.pop(context);
                            }
                          },
                          child: Center(
                            child: Text('UPDATE ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat')),
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
        ]),
      ),
      // body: Stack(
      //   children: <Widget>[
      //     Container(
      //       height: 225.0,
      //       color: Color(0xFF20D3D2),
      //     ),
      //     Align(
      //       alignment: Alignment.topLeft,
      //       child: Padding(
      //         padding: const EdgeInsets.only(top: 10.0),
      //         child: IconButton(
      //             icon: Icon(Icons.arrow_back),
      //             color: Colors.white,
      //             onPressed: () {}),
      //       ),
      //     ),
      //     Align(
      //       alignment: Alignment.topCenter,
      //       child: Padding(
      //           padding: const EdgeInsets.only(top: 40.0),
      //           child: Text(
      //             'Update Profile',
      //             style: TextStyle(
      //               fontSize: 24.0,
      //               fontWeight: FontWeight.bold,
      //               color: Colors.white,
      //             ),
      //           )),
      //     ),
      //     Positioned(
      //       top: 100.0,
      //       child: Container(
      //         height: screenHeight - 100.0,
      //         width: screenWidth,
      //         decoration: BoxDecoration(
      //             color: Colors.white,
      //             borderRadius: BorderRadius.only(
      //                 topLeft: Radius.circular(40.0),
      //                 topRight: Radius.circular(40.0))),
      //         child: ListView(
      //           children: <Widget>[
      //             Padding(
      //               padding: EdgeInsets.only(
      //                   top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
      //               child: Container(
      //                 width: screenWidth - 40.0,
      //                 child: Column(
      //                   children: <Widget>[
      //                     Container(
      //                       height: screenHeight - 100,
      //                       width: screenWidth,
      //                       decoration: BoxDecoration(
      //                         borderRadius: BorderRadius.circular(12.0),
      //                         color: Color(0xFF20D3D2),
      //                       ),
      //                       child: ListView(
      //                         children: <Widget>[
      //                           Form(
      //                             key: _formkey,
      //                             child: Column(
      //                               children: <Widget>[
      //                                 SizedBox(height: 10.0),
      //                                 TextFormField(
      //                                   decoration: decoration.copyWith(
      //                                       labelText: ' username'),
      //                                   onChanged: (value) {
      //                                     setState(() {
      //                                       username = value;
      //                                     });
      //                                   },
      //                                 ),
      //                                 SizedBox(height: 5.0),
      //                                 TextFormField(
      //                                   decoration: decoration.copyWith(
      //                                       labelText: 'email'),
      //                                   onChanged: (value) {
      //                                     setState(() {
      //                                       useremail = value;
      //                                     });
      //                                   },
      //                                 ),
      //                                 TextFormField(
      //                                   decoration: decoration.copyWith(
      //                                       labelText: 'location'),
      //                                   onChanged: (value) {
      //                                     setState(() {
      //                                       location = value;
      //                                     });
      //                                   },
      //                                 ),
      //                                 SizedBox(height: 7.0),
      //                                 Container(
      //                                   height: 40.0,
      //                                   width: 105.0,
      //                                   child: Material(
      //                                     borderRadius:
      //                                         BorderRadius.circular(20.0),
      //                                     shadowColor: Colors.greenAccent,
      //                                     color: Colors.green,
      //                                     elevation: 7.0,
      //                                     child: GestureDetector(
      //                                       onTap: getImage,
      //                                       child: Center(
      //                                         child: Text(
      //                                           'Select Image',
      //                                           style: TextStyle(
      //                                             color: Colors.white,
      //                                             fontFamily: 'Montserrat',
      //                                             fontWeight: FontWeight.bold,
      //                                           ),
      //                                         ),
      //                                       ),
      //                                     ),
      //                                   ),
      //                                 ),
      //                                 sampleImage != null
      //                                     ? Container(
      //                                         child: Image.file(sampleImage,
      //                                             height: 150.0, width: 200.0),
      //                                       )
      //                                     : Container(
      //                                         height: 20.0,
      //                                       ),
      //                                 Container(
      //                                     height: 60.0,
      //                                     width: 205.0,
      //                                     child: Material(
      //                                       borderRadius:
      //                                           BorderRadius.circular(20.0),
      //                                       shadowColor: Colors.greenAccent,
      //                                       color: Colors.green,
      //                                       elevation: 7.0,
      //                                       child: GestureDetector(
      //                                         onTap: () async {
      //                                           FirebaseUser user =
      //                                               await FirebaseAuth.instance
      //                                                   .currentUser();
      //                                           final StorageReference
      //                                               firebaseStorageRef =
      //                                               FirebaseStorage.instance
      //                                                   .ref()
      //                                                   .child(username);
      //                                           final StorageTaskSnapshot
      //                                               snapshot =
      //                                               await firebaseStorageRef
      //                                                   .putFile(sampleImage)
      //                                                   .onComplete;
      //                                           if (snapshot.error == null) {
      //                                             final String downloadUrl =
      //                                                 await snapshot.ref
      //                                                     .getDownloadURL();
      //                                             Firestore.instance
      //                                                 .collection('users')
      //                                                 .document(user.uid)
      //                                                 .setData({
      //                                               'username': username,
      //                                               'email': useremail,
      //                                               'imageurl': downloadUrl,
      //                                               'location': location,
      //                                             });
      //                                             Navigator.pop(context);
      //                                           }
      //                                         },
      //                                         child: Center(
      //                                           child: Text(
      //                                             'UPDATE PROFILE',
      //                                             style: TextStyle(
      //                                                 color: Colors.white,
      //                                                 fontFamily: 'Montserrat',
      //                                                 fontWeight:
      //                                                     FontWeight.bold,
      //                                                 fontSize: 24.0),
      //                                           ),
      //                                         ),
      //                                       ),
      //                                     )),
      //                               ],
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     )
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}
