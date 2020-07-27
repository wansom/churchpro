import 'package:churchpro/modals/caart_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class CartService {
//get data from product collection
  final CollectionReference cartDectailCollection =
      Firestore.instance.collection('cart');
  //read from product details map
  List<ProductCart> _cartDetails(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return ProductCart(
        productcode: doc.data['productcode'] ?? '',
        productinfo: doc.data['productinfo'] ?? '',
        productname: doc.data['productname'] ?? '',
        productprice: doc.data['productprice'] ?? '',
      );
    }).toList();
  }

  //product collection details stream
  Stream<List<ProductCart>> get products {
    return cartDectailCollection
        .where('productcode', isEqualTo: '03600045653')
        .snapshots()
        .map((_cartDetails));
  }

  // //create product collection;
  // void addtoCart(cartData) async {
  //   print(_authService.user);
  //   await Firestore.instance
  //       .collection("cart")
  //       .document()
  //       .setData(cartData)
  //       .then((value) => null);
  // }

  void addtoCart(cartData, superData) async {
    //get current user
    //var firebaseUser = await FirebaseAuth.instance.currentUser();

    Firestore.instance.collection("cart").add(cartData).then((value) {
      print(value.documentID);
      Firestore.instance
          .collection("cart")
          .document(value.documentID)
          .collection("pets")
          .add(superData);
    });
  }
}
