import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User?> get user => _auth.authStateChanges();

  //login with google
  Future<User?> googleSignIn() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final cred = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential res = await _auth.signInWithCredential(cred);
    User? user = res.user;

    if (user == null) {
      // ignore: avoid_print
      print('error loggin in anon');
      return null;
    } else {
      updateUserData(user);
      return user;
    }
  }

  Future<User?> anonSignIn() async {
    UserCredential res = await _auth.signInAnonymously();

    User? user = res.user;

    if (user == null) {
      // ignore: avoid_print
      print('error loggin in google');
      return null;
    } else {
      updateUserData(user);
      return user;
    }
  }

  Future<void> updateUserData(User user) {
    DocumentReference docRef = _db.collection('reports').doc(user.uid);

    return docRef.set({
      'uid': user.uid,
      'lastActivity': DateTime.now(),
    }, SetOptions(merge: true));
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}
