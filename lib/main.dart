import 'package:churchpro/app.dart';
import 'package:churchpro/screens/auth/update_profile.dart';
import 'package:churchpro/screens/home/product_details.dart';
import 'package:churchpro/screens/home/superdetail.dart';
import 'package:churchpro/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => MyHomePage(),
          '/superdetail': (context) => SuperDetail(),
          '/productdetails': (context) => ProductDetail(),
          '/updateprofile': (context) => UpdateProfile(),
        },
      ),
    );
  }
}
