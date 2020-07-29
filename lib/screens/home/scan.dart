import 'package:barcode_scan/barcode_scan.dart';
import 'package:churchpro/services/database/cart_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScanProduct extends StatefulWidget {
  @override
  _ScanProductState createState() => _ScanProductState();
}

class _ScanProductState extends State<ScanProduct> {
  var resultName = 'no results';
  var resultCode = '';
  var resultPrice = '';
  var resultInfo = '';

  ScanResult barcode;
  CartService cartServiceInstance = CartService();
  @override
  build(BuildContext context) {
    myText() {
      if (barcode != null) {
        return Container(
          height: MediaQuery.of(context).size.height / 3,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.shopping_cart),
                      onPressed: () {
                        cartServiceInstance.addtoCart({
                          'productname': resultName,
                          'productinfo': resultInfo,
                          'productcode': resultCode,
                          'productprice': resultPrice,
                        }, {});
                      }),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(resultName),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(resultPrice),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(resultInfo),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(resultCode),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        return Text('Scan to see results');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Scan'),
      ),
      body: ListView(
        children: <Widget>[
          myText(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 9.0,
        onPressed: scanMe,
        backgroundColor: Colors.orange,
        child: Icon(Icons.camera),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Future scanMe() async {
    try {
      ScanResult result = await BarcodeScanner.scan();
      setState(() {
        barcode = result;
      });
      //get result of the barcode and show related products
      if (barcode != null) {
        await Firestore.instance
            .collection('products')
            .where('productcode', isEqualTo: barcode.rawContent)
            .getDocuments()
            .then((value) {
          value.documents.forEach((element) {
            setState(() {
              resultName = element.data['productname'] ?? 'no results found';
              resultCode = element.data['productcode'] ?? 'no results found';
              resultPrice = element.data['productprice'] ?? 'no results found';
              resultInfo = element.data['productinfo'] ?? 'no results found';
            });
          });
        });
      } else {
        print('result not found');
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
