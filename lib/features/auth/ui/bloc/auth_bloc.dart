import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subablog/features/auth/domain/usecases/signup_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignupUsecase _signupUsecase;
  AuthBloc({required SignupUsecase signupUsecase})
    : _signupUsecase = signupUsecase,
      super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      emit(AuthLoading());

      final response = await _signupUsecase(
        params: UserSignUpParams(
          email: event.email,
          name: event.name,
          password: event.password,
        ),
      );

      response.fold(
        (l) => emit(AuthFailure(msg: l.message)),
        (r) => emit(AuthSuccess(uid: r)),
      );
    });
  }
}
