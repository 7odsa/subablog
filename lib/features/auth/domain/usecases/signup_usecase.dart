import 'package:fpdart/fpdart.dart';
import 'package:subablog/core/error/failure.dart';
import 'package:subablog/core/usecase/usecase.dart';
import 'package:subablog/features/auth/domain/repos/auth_repo.dart';

class SignupUsecase implements Usecase<String, UserSignUpParams> {
  final AuthRepo authRepo;

  SignupUsecase({required this.authRepo});

  @override
  Future<Either<Failure, String>> call({
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
