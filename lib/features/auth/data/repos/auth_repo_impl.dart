import 'package:fpdart/fpdart.dart';
import 'package:subablog/core/error/exeptions.dart';
import 'package:subablog/core/error/failure.dart';
import 'package:subablog/features/auth/data/data_sources/auth_remote_ds.dart';
import 'package:subablog/core/common/entities/user_entity.dart';
import 'package:subablog/features/auth/domain/repos/auth_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sp;

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDs authRemoteDs;

  AuthRepoImpl({required this.authRemoteDs});

  @override
  Future<Either<Failure, UserEntity>> currentUser() {
    return _getUser(() => authRemoteDs.getCurrentUserData());
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _getUser(
      () async => await authRemoteDs.loginWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return await _getUser(
      () async => await authRemoteDs.signUpWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, UserEntity>> _getUser(
    Future<UserEntity?> Function() fn,
  ) async {
    try {
      final user = await fn();
      return (user != null) ? right(user) : left(Failure("No User"));
    } on sp.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerExeption catch (e) {
      return left(Failure(e.message));
    }
  }
}
