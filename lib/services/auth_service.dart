import 'package:firebase_auth/firebase_auth.dart';

import 'firestore_service.dart';

class AuthService {

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  // ☁️ FIRESTORE
  final FirestoreService
      firestoreService =
      FirestoreService();

  // 🔐 SIGN UP
  Future<User?> signUp(
    String email,
    String password,
  ) async {

    try {

      UserCredential userCredential =
          await _auth
              .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 👤 CURRENT USER
      User? user =
          userCredential.user;

      // ☁️ SAVE USER TO FIRESTORE
      if (user != null) {

        await firestoreService
            .saveUser(

          uid: user.uid,

          email:
              user.email ?? "",
        );
      }

      return user;

    } catch (e) {

      print(e);

      return null;
    }
  }

  // 🔑 LOGIN
  Future<User?> signIn(
    String email,
    String password,
  ) async {

    try {

      UserCredential userCredential =
          await _auth
              .signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user;

    } catch (e) {

      print(e);

      return null;
    }
  }

  // 🚪 LOGOUT
  Future<void> signOut() async {

    await _auth.signOut();
  }
}