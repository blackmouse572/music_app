//Track device's unlock packages

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:music_app/models/package.model.dart';

abstract class UnlockPackagesStorage {
  Future<List<Package>> getUnlockPackages();
  Future<void> unlockPackage(Package package);
}

class UserUnlockPackagesStorage implements UnlockPackagesStorage {
  final _storage = const FlutterSecureStorage();
  @override
  Future<List<Package>> getUnlockPackages() async {
    final jsonString = await _storage.read(key: "unlockPackages");
    if (jsonString == null) {
      return [];
    }

    final List<dynamic> jsonRes = json.decode(jsonString);
    return jsonRes.map((e) => Package.fromJson(e)).toList();
  }

  @override
  Future<void> unlockPackage(Package package) async {
    final List<Package> packages = await getUnlockPackages();
    packages.add(package);
    final jsonString = json.encode(packages);
    await _storage.write(key: "unlockPackages", value: jsonString);
  }
}

final unlockPackagesProvider = FutureProvider<List<Package>>(
  (ref) async {
    final storage = ref.read(unlockPackagesStorageProvider);
    return storage.getUnlockPackages();
  },
);

final unlockPackagesStorageProvider = Provider<UnlockPackagesStorage>(
  (ref) => UserUnlockPackagesStorage(),
);

final unlockPackagesNotifierProvider =
    StateNotifierProvider<UnlockPackagesNotifier, List<Package>>(
  (ref) => UnlockPackagesNotifier(ref.read(unlockPackagesStorageProvider)),
);

class UnlockPackagesNotifier extends StateNotifier<List<Package>> {
  final UnlockPackagesStorage _storage;

  UnlockPackagesNotifier(this._storage) : super([]) {
    init();
  }

  Future<void> init() async {
    state = await _storage.getUnlockPackages();
  }

  Future<void> unlockPackage(Package package) async {
    await _storage.unlockPackage(package);
    state = await _storage.getUnlockPackages();
  }
}
