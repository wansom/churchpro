import 'package:churchpro/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        body: Stack(
      children: <Widget>[
        Container(
          height: 225.0,
          color: Color(0xFF20D3D2),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: IconButton(
              icon: Icon(Icons.person_outline),
              color: Colors.white,
              onPressed: () {},
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {},
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height / 9,
          child: Column(
            children: <Widget>[
              Container(
                width: 150.0,
                height: 150.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.all(Radius.circular(75.0)),
                  boxShadow: [
                    BoxShadow(blurRadius: 7.0, color: Colors.black),
                  ],
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
                          width: screenWidth,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              SizedBox(height: 5.0),
                              Text(
                                'ScanPay User',
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
                                  height: 60.0,
                                  width: 205.0,
                                  child: Material(
                                    borderRadius: BorderRadius.circular(20.0),
                                    shadowColor: Colors.greenAccent,
                                    color: Colors.green,
                                    elevation: 7.0,
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Center(
                                        child: Text(
                                          'Edit Profile',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24.0),
                                        ),
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                height: 15.0,
                              ),
                              Container(
                                height: 60.0,
                                width: 205.0,
                                child: Material(
                                  borderRadius: BorderRadius.circular(20.0),
                                  shadowColor: Colors.redAccent,
                                  color: Colors.red,
                                  elevation: 7.0,
                                  child: GestureDetector(
                                    onTap: () {
                                      _auth.signOut();
                                    },
                                    child: Center(
                                      child: Text(
                                        'Log out',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
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
