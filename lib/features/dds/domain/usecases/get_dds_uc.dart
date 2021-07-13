import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecases.dart/usecase.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/secure_storage.dart';
import '../entities/dds_entity.dart';
import '../repositories/i_dds_repository.dart';

class GetDDS implements UseCase<List<DDS>, PagedParams> {
  final IDDSRepository ddsRepository;
  String? _authKey;

  GetDDS({required this.ddsRepository});

  @override
  Future<Either<Failure, List<DDS>>> call(PagedParams params) async {
    _authKey = await SecureCtorage.getAuthKey();
    return ddsRepository.getDDSPaged(page: params.page, authKey: _authKey!);
  }
}
