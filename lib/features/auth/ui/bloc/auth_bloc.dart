import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:subablog/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:subablog/core/usecase/usecase.dart';
import 'package:subablog/core/common/entities/user_entity.dart';
import 'package:subablog/features/auth/domain/usecases/current_user_usecase.dart';
import 'package:subablog/features/auth/domain/usecases/login_usecase.dart';
import 'package:subablog/features/auth/domain/usecases/signup_usecase.dart';
import 'package:subablog/core/error/failure.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignupUsecase _signupUsecase;
  final LoginUsecase _loginUsecase;
  final CurrentUserUsecase _currentUserUsecase;

  final AppUserCubit _appUserCubit;
  AuthBloc({
    required SignupUsecase signupUsecase,
    required LoginUsecase loginUsecase,
    required CurrentUserUsecase currUserUsecase,
    required AppUserCubit appUserCubit,
  }) : _signupUsecase = signupUsecase,
       _loginUsecase = loginUsecase,
       _currentUserUsecase = currUserUsecase,
       _appUserCubit = appUserCubit,
       super(AuthInitial()) {
    on<AuthEvent>((event, emit) => emit(AuthLoading()));
    on<AuthSignUp>((event, emit) async {
      await _onAuth(
        emit,
        event,
        () async => await _signupUsecase(
          params: UserSignUpParams(
            email: event.email,
            name: event.name,
            password: event.password,
          ),
        ),
      );
    });
    on<AuthLogin>((event, emit) async {
      await _onAuth(
        emit,
        event,
        () async => await _loginUsecase(
          params: LoginParams(email: event.email, password: event.password),
        ),
      );
    });
    on<AuthIsUserLoggedin>(_isUserLoggedIn);
  }

  FutureOr<void> _isUserLoggedIn(
    AuthIsUserLoggedin event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _currentUserUsecase(params: NoParams());

    response.fold(
      (l) => emit(AuthFailure(msg: l.message)),
      (r) => _emitAuthSUccess(r, emit),
    );
  }

  Future<void> _onAuth(
    Emitter<AuthState> emit,
    AuthEvent event,
    Future<Either<Failure, UserEntity>> Function() fn,
  ) async {
    final response = await fn();

    response.fold(
      (l) => emit(AuthFailure(msg: l.message)),
      (r) => _emitAuthSUccess(r, emit),
    );
  }

  void _emitAuthSUccess(UserEntity user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user: user));
  }
}
