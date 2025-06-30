import 'package:fpdart/fpdart.dart';
import 'package:subablog/core/error/failure.dart';
import 'package:subablog/core/usecase/usecase.dart';
import 'package:subablog/core/common/entities/user_entity.dart';
import 'package:subablog/features/auth/domain/repos/auth_repo.dart';

class LoginUsecase implements Usecase<UserEntity, LoginParams> {
  final AuthRepo _authRepo;

  LoginUsecase({required AuthRepo authRepo}) : _authRepo = authRepo;
  @override
  Future<Either<Failure, UserEntity>> call({
    required LoginParams params,
  }) async {
    return await _authRepo.loginWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}
