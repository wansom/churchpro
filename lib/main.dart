import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:provider/provider.dart';
import 'package:scanpay/app.dart';
import 'package:scanpay/screens/auth/update_profile.dart';
import 'package:scanpay/screens/home/scan.dart';
import 'package:scanpay/services/auth/auth_service.dart';

void main() {
  /*Set Consumer credentials before initializing the payment.
    You can get  them from https://developer.safaricom.co.ke/ by creating
    an account and an app.
     */
  MpesaFlutterPlugin.setConsumerKey("Znta2q3LCscb9grTZ7p0CIbc1dJIfTTl");
  MpesaFlutterPlugin.setConsumerSecret("VC0RP4OVeD4tR70H");
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
          '/updateprofile': (context) => UpdateProfile(),
          '/scan': (context) => ScanProduct(),
        },
      ),
    );
  }
}
