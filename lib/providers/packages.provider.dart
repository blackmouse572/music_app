import 'package:cloud_firestore/cloud_firestore.dart';
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
    required bool isLoading,
    required bool isErrored,
    required String errorMessage,
  }) = _PackagesState;
}

class PackagesProvider extends StateNotifier<PackagesState> {
  final FirebaseFirestore _firestore;
  PackagesProvider(this._firestore)
      : super(const PackagesState(
            packages: [],
            isLoading: true,
            isErrored: false,
            errorMessage: '')) {
    fetchPackages();
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
}

final packagesProvider = StateNotifierProvider<PackagesProvider, PackagesState>(
  (ref) => PackagesProvider(FirebaseFirestore.instance),
);
