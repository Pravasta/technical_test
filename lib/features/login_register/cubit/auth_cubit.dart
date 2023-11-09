import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:technical_test/features/login_register/model/user.dart';

import '../../../service/auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthLoading());
      UserModel user = await AuthService().signUp(
        name: name,
        email: email,
        password: password,
      );

      emit(AuthSucces(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signOut() async {
    try {
      emit(AuthLoading());
      await AuthService().signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void getCurrentUser(String id) async {
    try {
      UserModel user = await AuthService().getUserById(id);
      emit(AuthSucces(user));
    } catch (e) {
      emit(
        AuthFailed(
          e.toString(),
        ),
      );
    }
  }

  void singIn({required String email, required String password}) async {
    try {
      emit(AuthLoading());
      UserModel user =
          await AuthService().signin(email: email, password: password);
      emit(AuthSucces(user));
    } catch (e) {
      emit(
        AuthFailed(e.toString()),
      );
    }
  }

  void resetPassword(String email) async {
    try {
      emit(AuthLoading());
      await AuthService().resetPassword(email);
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
