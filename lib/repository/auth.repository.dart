import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>(
    (ref) => AuthRepository(FirebaseAuth.instance, FirebaseFirestore.instance));

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _store;

  AuthRepository(this._auth, this._store);

  Future<UserCredential?> signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      //Set loading state
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e, stacktrace) {
      String message = "";
      if (e.code == 'user-not-found' ||
          e.code == 'invalid-email' ||
          e.code == 'wrong-password') {
        message = "Sai email hoặc mật khẩu";
      } else {
        debugPrintStack(label: e.toString(), stackTrace: stacktrace);
        message = "Đã có lỗi xảy ra";
      }
      //Show error message on snackbar
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
      return null;
    }
  }

  void signOut() async {
    await _auth.signOut();
  }

  Future<UserCredential?> signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return result;

      //save user to firestore
    } on FirebaseAuthException catch (e, stacktrace) {
      String message = "";
      if (e.code == 'email-already-in-use') {
        message = "Email đã được sử dụng";
      } else {
        debugPrintStack(label: e.toString(), stackTrace: stacktrace);
        message = "Đã có lỗi xảy ra";
      }
      //Show error message on snackbar
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
      return null;
    }
  }

  void updatePassword({
    required String newPassword,
    required BuildContext context,
  }) {
    try {
      _auth.currentUser!.updatePassword(newPassword);
    } on FirebaseAuthException catch (e, stacktrace) {
      String message = "";
      if (e.code == 'weak-password') {
        message = "Mật khẩu quá yếu";
      } else {
        debugPrintStack(label: e.toString(), stackTrace: stacktrace);
        message = "Đã có lỗi xảy ra";
      }
      //Show error message on snackbar
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  //Auth state changes
  Stream<User?> authStateChanges() => _auth.authStateChanges();
}
