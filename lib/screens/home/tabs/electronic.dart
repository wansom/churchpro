import 'package:flutter/material.dart';
import 'package:churchpro/modals/products.dart';
import 'package:churchpro/services/database/products_service.dart';
import 'package:churchpro/screens/loading.dart';

class Electronics extends StatefulWidget {
  final ValueSetter<Products> _valueSetter;

  Electronics(this._valueSetter);

  @override
  _ElectronicsState createState() => _ElectronicsState();
}

class _ElectronicsState extends State<Electronics> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Products>>(
        stream: ProductService().products,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var productData = snapshot.data;
            return Container(
              padding: EdgeInsets.only(right: 15.0),
              width: MediaQuery.of(context).size.width - 30.0,
              height: MediaQuery.of(context).size.height * (60 / 100),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: productData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: EdgeInsets.only(
                            top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
                        child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/cart', arguments: {
                                'productName': productData[index].productinfo,
                                'productImage': productData[index].productcode,
                                'productPrice': productData[index].productprice,
                              });
                              widget._valueSetter(productData[index]);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 3.0,
                                          blurRadius: 5.0)
                                    ],
                                    color: Colors.white),
                                child: Column(children: [
                                  Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            productData[index].isfavorite
                                                ? Icon(Icons.favorite,
                                                    color: Color(0xFFFE7D6A))
                                                : Icon(Icons.favorite_border,
                                                    color: Color(0xFFFE7D6A))
                                          ])),
                                  Container(
                                      height: 38.0,
                                      width: 75.0,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  productData[index].imageurl),
                                              fit: BoxFit.contain))),
                                  SizedBox(height: 3.0),
                                  Text('${productData[index].productprice}',
                                      style: TextStyle(
                                          color: Color(0xFFFE7D6A),
                                          fontFamily: 'Varela',
                                          fontSize: 14.0)),
                                  Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Container(
                                          color: Color(0xFFEBEBEB),
                                          height: 1.0)),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 5.0, right: 5.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            if (!productData[index]
                                                .isfeatured) ...[
                                              Icon(Icons.shopping_basket,
                                                  color: Color(0xFFD17E50),
                                                  size: 12.0),
                                              Text('Add to cart',
                                                  style: TextStyle(
                                                      fontFamily: 'Varela',
                                                      color: Color(0xFFFE7D6A),
                                                      fontSize: 12.0))
                                            ],
                                            if (productData[index]
                                                .isfeatured) ...[
                                              Icon(Icons.remove_circle_outline,
                                                  color: Color(0xFFFE7D6A),
                                                  size: 12.0),
                                              Text('3',
                                                  style: TextStyle(
                                                      fontFamily: 'Varela',
                                                      color: Color(0xFFD17E50),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12.0)),
                                              Icon(Icons.add_circle_outline,
                                                  color: Color(0xFFFE7D6A),
                                                  size: 12.0),
                                            ]
                                          ]))
                                ]))));
                  }),
            );
          } else {
            return Container(
              child: Loading(),
            );
          }
        });
  }
}
