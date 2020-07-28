import 'package:churchpro/screens/home/tabs/electronic.dart';
import 'package:churchpro/screens/home/tabs/fashion.dart';
import 'package:churchpro/screens/home/tabs/food.dart';
import 'package:flutter/material.dart';
import 'package:churchpro/modals/products.dart';

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
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    selectedProduct = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFFE7D6A)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(selectedProduct['selectedName'],
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 20.0,
                color: Color(0xFF545D68))),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications_none, color: Color(0xFFFE7D6A)),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(left: 20.0),
          children: <Widget>[
            SizedBox(height: 15.0),
            Text('Categories',
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 15.0),
            TabBar(
                controller: _tabController,
                indicatorColor: Colors.transparent,
                labelColor: Color(0xFFFE7D6A),
                isScrollable: true,
                labelPadding: EdgeInsets.only(right: 45.0),
                unselectedLabelColor: Color(0xFFFE7D6A),
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
                ]),
            Container(
                height: MediaQuery.of(context).size.height - 50.0,
                width: double.infinity,
                child: TabBarView(controller: _tabController, children: [
                  Electronics((selectedProduct) {
                    setState(() {
                      cart.add(selectedProduct);
                      sum = 0;
                      cart.forEach((item) {
                        sum = sum + item.productprice;
                      });
                    });
                  }),
                  Food(),
                  Fashion(),
                ]))
          ],
        ),
      ),
    );
  }
}
