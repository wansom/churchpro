import 'package:scanpay/modals/products.dart';

class Supermarkets {
  String superName;
  String stores;
  String image;
  List locations;
  List<Products> superProducts;
  Supermarkets(
      {this.locations,
      this.stores,
      this.superName,
      this.superProducts,
      this.image});
}
