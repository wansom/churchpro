import 'package:churchpro/screens/home/AddProducts.dart';
import 'package:churchpro/screens/home/cart.dart';
import 'package:churchpro/screens/home/home.dart';
import 'package:churchpro/screens/home/profile.dart';
import 'package:churchpro/screens/home/scan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  //default index of first screen
  int _currentIndex = 0;
  List<Widget> myPages = [
    ScanProduct(),
    HomePage(),
    ShoppingCart(),
    ProfilePage(),
    AddProducts(),
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    print(user);
    return Scaffold(
      body: myPages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 9.0,
          selectedItemColor: Colors.green,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                title: Text('home')),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.explore,
              ),
              title: Text('Explore'),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_basket,
              ),
              title: Text('Cart'),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
              ),
              title: Text('Account'),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
              ),
              title: Text('Admin'),
            ),
          ]),
    );
  }
}
