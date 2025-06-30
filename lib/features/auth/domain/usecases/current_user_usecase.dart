import 'package:fpdart/fpdart.dart';
import 'package:subablog/core/error/failure.dart';
import 'package:subablog/core/usecase/usecase.dart';
import 'package:subablog/core/common/entities/user_entity.dart';
import 'package:subablog/features/auth/domain/repos/auth_repo.dart';

class CurrentUserUsecase implements Usecase<UserEntity, NoParams> {
  final AuthRepo authRepo;

  CurrentUserUsecase({required this.authRepo});

  @override
  Future<Either<Failure, UserEntity>> call({required NoParams params}) async {
    return await authRepo.currentUser();
  }
}
