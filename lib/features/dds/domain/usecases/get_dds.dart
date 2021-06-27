import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/secure_storage.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dds_entity.dart';
import '../repositories/i_dds_repository.dart';

class GetDDS implements UseCase<List<DDS>, DDSParams> {
  final IDDSRepository ddsRepository;
  String? _authKey;

  GetDDS({required this.ddsRepository});

  @override
  Future<Either<Failure, List<DDS>>> call(DDSParams params) async {
    _authKey = await SecureCtorage.getAuthKey();
    return ddsRepository.getDDSPaged(page: params.page, authKey: _authKey!);
  }
}

class DDSParams extends Equatable {
  final int page;

  const DDSParams({required this.page});

  @override
  List<Object?> get props => [page];
}
