import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:music_app/models/package.model.dart';
import 'package:music_app/models/playlist.model.dart';

part 'packages.provider.freezed.dart';

@freezed
abstract class PackagesState with _$PackagesState {
  const factory PackagesState({
    required List<Package> packages,
    required List<Package> unlockedPackages,
    required bool isLoading,
    required bool isErrored,
    required String errorMessage,
  }) = _PackagesState;
}

class PackagesProvider extends StateNotifier<PackagesState> {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  PackagesProvider(this._firestore, this._auth)
      : super(const PackagesState(
            packages: [],
            unlockedPackages: [],
            isLoading: true,
            isErrored: false,
            errorMessage: '')) {
    fetchPackages();
    init();
  }

  init() async {
    final packages = await getUnlockPackages();
    state = state.copyWith(unlockedPackages: packages);
  }

  Future<void> fetchPackages() async {
    final packagesQuery = _firestore.collection('packages');
    final playlistQuery = _firestore.collection('playlist');
    final packagesQuerySnapshot = await packagesQuery.get();
    try {
      final packages = packagesQuerySnapshot.docs.map((doc) async {
        final package = Package.fromJson(doc.data());
        final playlistIds = package.playlists.map((e) => e).toList();
        final playlistQuerySnapshot = await playlistQuery
            .where(FieldPath.documentId, whereIn: playlistIds)
            .get();
        final playlists = playlistQuerySnapshot.docs.map((doc) {
          final p = Playlist.fromJson(doc.data());
          return p.copyWith(id: doc.id);
        }).toList();

        final p = package.copyWith(playlistModels: playlists, id: doc.id);
        return p;
      }).toList();
      //wait for all packages to be fetched
      final packagesList = await Future.wait(packages);

      state = state.copyWith(packages: packagesList, isLoading: false);
    } catch (e, s) {
      state = state.copyWith(
          isErrored: true, errorMessage: e.toString(), isLoading: false);
      //Print stack trace of error
      debugPrint('Error while fetching packages: $e');
      debugPrintStack(stackTrace: s, label: 'Stack trace', maxFrames: 10);
    }
  }

  Future<List<Package>> getUnlockPackages() async {
    final user = _auth.currentUser;
    if (user == null) return [];
    final doc = await _firestore.collection("users").doc(user.uid).get();
    List<Package> packages = [];

    //get packages and add playlist to package
    if (doc.exists) {
      final data = doc.data();
      if (data != null) {
        final List<dynamic> packageIds = data["unlockPackages"];
        if (packageIds.isEmpty) return [];
        for (final packageId in packageIds) {
          final packageDoc =
              await _firestore.collection("packages").doc(packageId).get();
          if (packageDoc.exists) {
            final packageData = packageDoc.data();
            final playlistIds = packageData!["playlists"];
            final playlistQuerySnapshot = await _firestore
                .collection("playlist")
                .where(FieldPath.documentId, whereIn: playlistIds)
                .get();

            final playlists = playlistQuerySnapshot.docs.map((doc) {
              final p = Playlist.fromJson(doc.data());
              return p.copyWith(id: doc.id);
            }).toList();
            if (packageData != null) {
              packages.add(Package.fromJson(packageData)
                  .copyWith(playlistModels: playlists, id: packageId));
            }
          }
        }
      }
    }

    return packages;
  }

  Future<void> unlockPackage(Package package, BuildContext context) async {
    final user = _auth.currentUser;
    //Check is user is logged in
    if (user == null) return;
    final doc = await _firestore.collection("users").doc(user.uid).get();
    if (doc.exists) {
      final data = doc.data();
      if (data != null) {
        final List<dynamic> packageIds = data["unlockPackages"];
        if (!packageIds.contains(package.id)) {
          packageIds.add(package.id);
          await _firestore
              .collection("users")
              .doc(user!.uid)
              .update({"unlockPackages": packageIds});
        }
        //Update state
        state = state
            .copyWith(unlockedPackages: [...state.unlockedPackages, package]);
      }
    }
  }
}

final packagesProvider =
    StateNotifierProvider<PackagesProvider, PackagesState>((ref) {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  return PackagesProvider(firestore, auth);
});
