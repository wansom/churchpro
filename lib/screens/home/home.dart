import 'package:churchpro/screens/home/superlist.dart';
import 'package:churchpro/services/database/supermarket_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: SuperService().supermarkets,
      child: Scaffold(
        body: SafeArea(
            child: ListView(
          children: <Widget>[
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        image: DecorationImage(
                            image: AssetImage('assets/tuxedo.png'),
                            fit: BoxFit.cover)),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications),
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: Container(
                    padding: EdgeInsets.only(left: 5.0),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: GoogleFonts.notoSans(fontSize: 14.0),
                          border: InputBorder.none,
                          fillColor: Colors.grey.withOpacity(0.5),
                          prefixIcon: Icon(Icons.search, color: Colors.grey)),
                    ))),
            SizedBox(height: 7.0),
            Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text('Supermarkets',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 17.0))),
            SizedBox(height: 20.0),
            SuperList(),
          ],
        )),
      ),
    );
  }
}
