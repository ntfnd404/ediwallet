import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecases.dart/usecase.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/secure_storage.dart';
import '../entities/department_entity.dart';
import '../repositories/i_departments_repository.dart';

class GetDepartments implements UseCaseWithoutParams<List<Department>> {
  final IDepartmentsRepository repository;
  String? _authKey;

  GetDepartments({required this.repository});

  @override
  Future<Either<Failure, List<Department>>> call() async {
    _authKey = await SecureCtorage.getAuthKey();
    return repository.getList(authKey: _authKey!);
  }
}
