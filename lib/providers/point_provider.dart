import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:music_app/repository/user.repository.dart';

import 'auth.provider.dart';

part 'point_provider.freezed.dart';

@freezed
class PointState with _$PointState {
  const factory PointState(
      {required bool isLoading,
      required bool isAuth,
      required User? user,
      required int point}) = _PointState;
}

//update point based on auth provider state
final pointProvider = StateNotifierProvider<PointProvider, PointState>((ref) {
  final authState = ref.watch(authControllerProvider);
  final userRepo = ref.watch(userRepositoryProvider);
  final store = FirebaseFirestore.instance;
  final pointProvider = PointProvider(userRepo, store, authState.user);
  if (authState.isAuth) {
    pointProvider.init();
  }
  return pointProvider;
});

class PointProvider extends StateNotifier<PointState> {
  final UserRepository _userRepository;
  final FirebaseFirestore _store;

  PointProvider(this._userRepository, this._store, User? user)
      : super(const PointState(
          isLoading: false,
          isAuth: false,
          user: null,
          point: 0,
        )) {
    state = state.copyWith(isAuth: true, user: user);
  }

  void init() {
    //get point from firebase
    //if new user, create new point document
    getPoint();
  }

  void addPoint(BuildContext context) {
    state = state.copyWith(point: state.point + 100);
    _userRepository.updatePoints(state.user!.uid, state.point, context);
  }

  void updatePoint(BuildContext context, int newpoint) {
    _userRepository.updatePoints(state.user!.uid, state.point, context);
    state = state.copyWith(point: newpoint);
  }

  Future<void> getPoint() async {
    //get point from firebase
    int points = await _userRepository.getPoints(state.user!.uid);
    state = state.copyWith(point: points);
  }

  void registerPoint() {
    //create new point document
    _userRepository.registerUserPoint(state.user!.uid);
    state = state.copyWith(point: 0);
  }
}
