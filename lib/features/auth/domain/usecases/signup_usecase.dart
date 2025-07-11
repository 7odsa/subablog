import 'package:fpdart/fpdart.dart';
import 'package:subablog/core/error/failure.dart';
import 'package:subablog/core/usecase/usecase.dart';
import 'package:subablog/core/common/entities/user_entity.dart';
import 'package:subablog/features/auth/domain/repos/auth_repo.dart';

class SignupUsecase implements Usecase<UserEntity, UserSignUpParams> {
  final AuthRepo authRepo;

  SignupUsecase({required this.authRepo});

  @override
  Future<Either<Failure, UserEntity>> call({
    required UserSignUpParams params,
  }) async {
    return await authRepo.signUpWithEmailAndPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String name;
  final String password;

  UserSignUpParams({
    required this.email,
    required this.name,
    required this.password,
  });
}
