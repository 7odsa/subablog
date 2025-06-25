import 'package:fpdart/fpdart.dart';
import 'package:subablog/core/error/failure.dart';

abstract interface class AuthRepo {
  Future<Either<Failure, String>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, String>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
}
