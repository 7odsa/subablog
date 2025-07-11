part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final UserEntity user;

  const AuthSuccess({required this.user});
}

final class AuthFailure extends AuthState {
  final String msg;

  const AuthFailure({required this.msg});
}
