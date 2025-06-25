import 'package:fpdart/src/either.dart';
import 'package:subablog/core/error/exeptions.dart';
import 'package:subablog/core/error/failure.dart';
import 'package:subablog/features/auth/data/data_sources/auth_remote_ds.dart';
import 'package:subablog/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDs authRemoteDs;

  AuthRepoImpl({required this.authRemoteDs});

  @override
  Future<Either<Failure, String>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final uid = await authRemoteDs.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(uid);
    } on ServerExeption catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final uid = await authRemoteDs.signUpWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      );
      return right(uid);
    } on ServerExeption catch (e) {
      return left(Failure(e.message));
    }
  }
}
