import 'package:fpdart/fpdart.dart';
import 'package:subablog/core/error/failure.dart';

abstract interface class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call({required Params params});
}
