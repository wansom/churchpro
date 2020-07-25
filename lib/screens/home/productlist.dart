import 'package:churchpro/modals/products.dart';
import 'package:churchpro/services/database/cart_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  CartService cartServiceInstance = CartService();
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Products>>(context);
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(products[index].productname),
            subtitle: Text(products[index].productinfo),
            leading: Text(products[index].productcode),
            trailing: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  cartServiceInstance.addtoCart({
                    'productname': products[index].productname,
                    'productcode': products[index].productcode,
                    'productinfo': products[index].productinfo,
                    'productprice': products[index].productprice,
                  }, {
                    'supername': 'tuskys',
                    'stores': '23',
                  });
                }),
          ),
        );
      },
    );
  }
}
