import 'package:churchpro/modals/supermarkets_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SuperService {
  CollectionReference superCollection =
      Firestore.instance.collection('supermarkets');
  List<Supermarkets> _superDetails(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Supermarkets(
        superName: doc.data['supername'] ?? '',
        stores: doc.data['stores'] ?? '',
        image: doc.data['imageurl'] ?? '',
      );
    }).toList();
  }

  //product collection details stream
  Stream<List<Supermarkets>> get supermarkets {
    return superCollection.snapshots().map((_superDetails));
  }

  Stream<List<Supermarkets>> get mySupermarkets {
    return superCollection.snapshots().map((_superDetails));
  }

  //adding supermarkets
  void addSupermarket(superData) async {
    superCollection.add(superData);
  }
}
