import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/product.dart';

class WishlistService {

  final FirebaseFirestore
      _firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  // ❤️ ADD TO WISHLIST
  Future<void> addToWishlist(
    Product product,
  ) async {

    final user =
        _auth.currentUser;

    if (user == null) return;

    await _firestore
        .collection("users")
        .doc(user.uid)
        .collection("wishlist")
        .doc(product.name)
        .set({

      "name": product.name,
      "price": product.price,
      "image": product.image,
      "rating": product.rating,
      "category":
          product.category,
    });
  }

  // 💔 REMOVE FROM WISHLIST
  Future<void> removeFromWishlist(
    Product product,
  ) async {

    final user =
        _auth.currentUser;

    if (user == null) return;

    await _firestore
        .collection("users")
        .doc(user.uid)
        .collection("wishlist")
        .doc(product.name)
        .delete();
  }
}