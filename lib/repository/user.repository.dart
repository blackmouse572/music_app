import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/models/package.model.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final store = FirebaseFirestore.instance;
  final auth = firebase_auth.FirebaseAuth.instance;
  return UserRepository(store, auth);
});

class UserRepository {
  final FirebaseFirestore _store;
  final firebase_auth.FirebaseAuth _auth;

  UserRepository(this._store, this._auth);

  //Get user's purchase history
  List<Package> getOwnedPackages(String userId, BuildContext ctx) {
    final packages = <Package>[];
    try {
      _store
          .collection('users')
          .doc(userId)
          .collection('packages')
          .get()
          .then((value) {
        for (var element in value.docs) {
          packages.add(Package.fromJson(element.data()));
        }
      });
      return packages;
    } on Exception catch (e) {
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return packages;
    }
  }

  //Add a new package to user's purchase history
  void addPackageToUser(String userId, Package package, BuildContext ctx) {
    try {
      _store
          .collection('users')
          .doc(userId)
          .collection('packages')
          .doc(package.id)
          .set(package.toJson());
    } on Exception catch (e) {
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  //get user points
  Future<int> getPoints(String userId) async {
    int points = 0;
    try {
      await _store.collection('users').doc(userId).get().then((value) {
        points = value.data()!['points'];
      });
      return points;
    } on Exception catch (e, stack) {
      debugPrintStack(label: e.toString(), stackTrace: stack);
      return points;
    }
  }

  //Update user points
  void updatePoints(String userId, int points, BuildContext ctx) {
    try {
      _store.collection('users').doc(userId).update({'points': points});
    } on Exception catch (e) {
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

//create new user point document
  void registerUserPoint(String userId) {
    try {
      _store
          .collection('users')
          .doc(userId)
          .set({'points': 0, 'unlockPackages': []});
    } on Exception catch (e, st) {
      debugPrintStack(label: e.toString(), stackTrace: st);
    }
  }
}
