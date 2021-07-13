// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:ediwallet/core/error/failure.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

// abstract class UseCaseVoid<Type, Params> {
//   Future<Either<Failure, void>> call(Params params);
// }
abstract class UseCaseVoid<Type, Params> {
  void call(Params params);
}

abstract class UseCaseWithoutParams<Type> {
  Future<Either<Failure, Type>> call();
}

class PagedParams extends Equatable {
  final int page;

  const PagedParams({required this.page});

  @override
  List<Object?> get props => [page];
}
