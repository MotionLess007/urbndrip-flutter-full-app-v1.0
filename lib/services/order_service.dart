import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderService {

  final FirebaseFirestore
      _firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  // 📦 PLACE ORDER
  Future<void> placeOrder({

    required List<Map<String, dynamic>>
        items,

    required double total,

    required String name,

    required String email,

    required String phone,

    required String address,

    required String paymentMethod,
  }) async {

    final user =
        _auth.currentUser;

    if (user == null) return;

    // ☁️ SAVE ORDER
    await _firestore
        .collection("users")
        .doc(user.uid)
        .collection("orders")
        .add({

      "items": items,

      "total": total,

      "name": name,

      "email": email,

      "phone": phone,

      "address": address,

      "paymentMethod":
          paymentMethod,

      "createdAt":
          Timestamp.now(),
    });

    // 🗑️ CLEAR CART
    final cartDocs =
        await _firestore
            .collection("users")
            .doc(user.uid)
            .collection("cart")
            .get();

    for (var doc in cartDocs.docs) {

      await doc.reference.delete();
    }
  }
}