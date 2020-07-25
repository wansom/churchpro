import 'package:barcode_scan/barcode_scan.dart';
import 'package:churchpro/modals/products.dart';
import 'package:churchpro/screens/home/productlist.dart';
import 'package:churchpro/services/database/cart_service.dart';
import 'package:churchpro/services/database/products_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ScanProduct extends StatefulWidget {
  @override
  _ScanProductState createState() => _ScanProductState();
}

class _ScanProductState extends State<ScanProduct> {
  ScanResult barcode;
  CartService cartServiceInstance = CartService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Products>>.value(
      value: ProductService().products,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Scan'),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * (0.67),
              child: ProductList(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 9.0,
          onPressed: scanMe,
          backgroundColor: Colors.orange,
          child: Icon(Icons.camera),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Future scanMe() async {
    try {
      ScanResult result = await BarcodeScanner.scan();
      setState(() {
        barcode = result;
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
