import 'package:fpdart/fpdart.dart';
import 'package:subablog/core/error/failure.dart';
import 'package:subablog/core/common/entities/user_entity.dart';

abstract interface class AuthRepo {
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, UserEntity>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, UserEntity>> currentUser();
}
