import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:music_app/repository/auth.repository.dart';
import 'package:music_app/repository/user.repository.dart';

part 'auth.provider.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    required bool isLoading,
    required bool isAuth,
    required User? user,
    required bool isNewUser,
  }) = _AuthState;
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) => AuthController(
          ref.read(authRepositoryProvider),
          ref.read(userRepositoryProvider),
        ));

class AuthController extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  AuthController(this._authRepository, this._userRepository)
      : super(const AuthState(
          isLoading: false,
          isAuth: false,
          user: null,
          isNewUser: false,
        )) {
    //Listen to auth state change stream
    _authRepository.authStateChanges().listen((user) {
      if (user != null) {
        state = state.copyWith(isAuth: true, user: user);
      } else {
        state = state.copyWith(isAuth: false, user: null);
      }
    });
  }
  Future<bool> signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = state.copyWith(isLoading: true);
    final rs = await _authRepository.signIn(
        email: email, password: password, context: context);
    if (rs != null) {
      state = state.copyWith(isAuth: true, user: rs.user, isLoading: false);
      return true;
    }
    state = state.copyWith(isLoading: false);
    return false;
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = state.copyWith(isLoading: true);
    final credential = await _authRepository.signUp(
        email: email, password: password, context: context);
    //Login after signup
    if (credential != null) {
      //Create new user's point document
      _userRepository.registerUserPoint(credential.user!.uid);
      signIn(email: email, password: password, context: context);
      state = state.copyWith(
          isAuth: true,
          user: credential.user,
          isNewUser: true,
          isLoading: false);

      return true;
    }
    state = state.copyWith(isLoading: false);
    return false;
  }

  void signOut() async {
    _authRepository.signOut();
    state = state.copyWith(isAuth: false, user: null);
  }
}
