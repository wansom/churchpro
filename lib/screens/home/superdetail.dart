import 'package:churchpro/screens/home/tabs/electronic.dart';
import 'package:churchpro/screens/home/tabs/fashion.dart';
import 'package:churchpro/screens/home/tabs/food.dart';
import 'package:churchpro/screens/home/tabs/furniture.dart';
import 'package:flutter/material.dart';
import 'package:churchpro/modals/products.dart';
import 'package:google_fonts/google_fonts.dart';

class SuperDetail extends StatefulWidget {
  @override
  _SuperDetailState createState() => _SuperDetailState();
}

class _SuperDetailState extends State<SuperDetail>
    with SingleTickerProviderStateMixin {
  Map selectedProduct = {};
  TabController _tabController;
  List<Products> cart = [];
  int sum = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    selectedProduct = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(left: 20.0),
          children: <Widget>[
            SizedBox(height: 50.0),
            Padding(
              padding: EdgeInsets.only(left: 0.0, right: 15.0),
              child: Container(
                padding: EdgeInsets.only(left: 5.0),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.0)),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: selectedProduct['selectedName'],
                      hintStyle: GoogleFonts.notoSans(fontSize: 14.0),
                      border: InputBorder.none,
                      fillColor: Colors.grey.withOpacity(0.5),
                      prefixIcon: Icon(Icons.search, color: Colors.grey)),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text('Categories',
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 15.0),
            TabBar(
                controller: _tabController,
                indicatorColor: Colors.transparent,
                labelColor: Colors.green,
                isScrollable: true,
                labelPadding: EdgeInsets.only(right: 45.0),
                unselectedLabelColor: Colors.green,
                tabs: [
                  Tab(
                    child: Text('Electronics',
                        style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 21.0,
                        )),
                  ),
                  Tab(
                    child: Text('Fashion',
                        style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 21.0,
                        )),
                  ),
                  Tab(
                    child: Text('Food',
                        style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 21.0,
                        )),
                  ),
                  Tab(
                    child: Text('Furniture',
                        style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 21.0,
                        )),
                  ),
                ]),
            Container(
                height: MediaQuery.of(context).size.height - 50.0,
                width: double.infinity,
                child: TabBarView(controller: _tabController, children: [
                  Electronics(),
                  Fashion(),
                  Food(),
                  Furniture(),
                ]))
          ],
        ),
      ),
    );
  }
}
