import 'package:churchpro/modals/products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductService {
  //get current user
  var currentUser = FirebaseAuth.instance.currentUser();
//get data from product collection
  final CollectionReference productDectailCollection =
      Firestore.instance.collection('products');
  //read from product details map
  List<Products> _productDetails(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Products(
        productcode: doc.data['productcode'] ?? '',
        productinfo: doc.data['productinfo'] ?? '',
        productname: doc.data['productname'] ?? '',
        productprice: doc.data['productprice'] ?? '',
        imageurl: doc.data['imageurl'] ?? '',
        isfavorite: doc['isfavorite'] ?? false,
        isfeatured: doc['isfeatured'] ?? true,
      );
    }).toList();
  }

  //product collection details stream
  Stream<List<Products>> get products {
    return productDectailCollection.snapshots().map((_productDetails));
  }

  //create product collection;
  void createRecord(productData) async {
    DocumentReference ref =
        await Firestore.instance.collection("products").add(productData);
    print(ref.documentID);
  }
}
