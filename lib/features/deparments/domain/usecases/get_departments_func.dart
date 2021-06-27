import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/secure_storage.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/department_entity.dart';
import '../repositories/departments_repository.dart';

class GetDepartments implements UseCaseWithoutParams<List<Department>> {
  final DepartmentsRepository departmentsRepository;
  String? _authKey;

  GetDepartments({required this.departmentsRepository});

  @override
  Future<Either<Failure, List<Department>>> call() async {
    _authKey = await SecureCtorage.getAuthKey();
    return departmentsRepository.getDepartments(authKey: _authKey!);
  }
}
