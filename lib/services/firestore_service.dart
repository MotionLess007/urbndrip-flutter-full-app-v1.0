import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  final FirebaseFirestore
      _firestore =
      FirebaseFirestore.instance;

  // 👤 SAVE USER
  Future<void> saveUser({

    required String uid,
    required String email,

  }) async {

    await _firestore
        .collection("users")
        .doc(uid)
        .set({

      "email": email,

      "createdAt":
          Timestamp.now(),
    });
  }
}