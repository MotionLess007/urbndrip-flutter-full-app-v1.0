import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/product.dart';

class CartService {

  final FirebaseFirestore
      _firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  // 🛒 ADD TO CART
  Future<void> addToCart(
    Product product,
  ) async {

    final user =
        _auth.currentUser;

    if (user == null) return;

    final cartRef =
        _firestore
            .collection("users")
            .doc(user.uid)
            .collection("cart")
            .doc(product.name);

    final doc =
        await cartRef.get();

    // ➕ IF EXISTS
    if (doc.exists) {

      int currentQuantity =
          doc["quantity"];

      await cartRef.update({

        "quantity":
            currentQuantity + 1,
      });

    }

    // 🆕 NEW PRODUCT
    else {

      await cartRef.set({

        "name": product.name,
        "price": product.price,
        "image": product.image,
        "rating": product.rating,
        "category":
            product.category,

        "quantity": 1,
      });
    }
  }

  // ❌ REMOVE ITEM
  Future<void> removeFromCart(
    String productName,
  ) async {

    final user =
        _auth.currentUser;

    if (user == null) return;

    await _firestore
        .collection("users")
        .doc(user.uid)
        .collection("cart")
        .doc(productName)
        .delete();
  }

  // ➕ UPDATE QUANTITY
  Future<void> updateQuantity(
    String productName,
    int quantity,
  ) async {

    final user =
        _auth.currentUser;

    if (user == null) return;

    await _firestore
        .collection("users")
        .doc(user.uid)
        .collection("cart")
        .doc(productName)
        .update({

      "quantity": quantity,
    });
  }
}