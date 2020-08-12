import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanpay/services/auth/auth_service.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('users')
                  .where('uid', isEqualTo: user.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var mySnapshot = snapshot.data;
                  return ListView.builder(
                    itemCount: mySnapshot.documents.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot products = mySnapshot.documents[index];
                      return Column(
                        children: <Widget>[
                          Container(
                            width: screenWidth,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Container(
                                      width: 150.0,
                                      height: 150.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        image: DecorationImage(
                                            image: NetworkImage(products[
                                                    'imageurl'] ??
                                                'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(75.0)),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 7.0,
                                              color: Colors.black),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    products['username'] ?? 'User',
                                    style: TextStyle(
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat'),
                                  ),
                                  SizedBox(height: 15.0),
                                  Text(
                                    products['email'] ?? 'user@scanpay.com',
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontStyle: FontStyle.italic,
                                        fontFamily: 'Montserrat'),
                                  ),
                                  SizedBox(height: 25.0),
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
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: FlatButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/updateprofile');
                                        },
                                        child: Center(
                                          child: Text('Edit Profile ',
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
                                            color: Colors.red,
                                            style: BorderStyle.solid,
                                            width: 1.0),
                                        color: Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: FlatButton(
                                        onPressed: () {
                                          _auth.signOut();
                                        },
                                        child: Center(
                                          child: Text('Sign Out',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Montserrat')),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return ListView(
                    children: <Widget>[
                      Container(
                        width: screenWidth,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              SizedBox(
                                height: 30.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  width: 150.0,
                                  height: 150.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
                                        fit: BoxFit.cover),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(75.0)),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 7.0, color: Colors.black),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                ' User',
                                style: TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                              SizedBox(height: 15.0),
                              Text(
                                user.email,
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontStyle: FontStyle.italic,
                                    fontFamily: 'Montserrat'),
                              ),
                              SizedBox(height: 25.0),
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
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: FlatButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/updateprofile');
                                    },
                                    child: Center(
                                      child: Text('Edit Profile ',
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
                                        color: Colors.red,
                                        style: BorderStyle.solid,
                                        width: 1.0),
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: FlatButton(
                                    onPressed: () {
                                      _auth.signOut();
                                    },
                                    child: Center(
                                      child: Text('Sign Out',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Montserrat')),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }),
        ),
      ),
    ));
    //     body: new Stack(
    //   children: <Widget>[
    //     ClipPath(
    //       child: Container(color: Colors.green.withOpacity(0.8)),
    //       clipper: GetClipper(),
    //     ),

    //
    //
    //             SizedBox(height: 25.0),
    //
    //   ],
    // ));
  }
}

class GetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // ignore: todo
    // TODO: implement shouldReclip
    return true;
  }
}
