import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {

  final FirebaseFirestore
      _firestore =
      FirebaseFirestore.instance;

  // ☁️ GET PRODUCTS
  Stream<QuerySnapshot>
      getProducts() {

    return _firestore
        .collection("products")
        .snapshots();
  }
}