import 'package:dwallet/app/core/either.dart';
import 'package:dwallet/app/core/failures.dart';
import 'package:dwallet/app/domain/repository/app_repository.dart';

import '../../../core/use_case.dart';
import '../../../web3/web3dart.dart';

class GetGasUseCase implements UseCase<EtherAmount,Params>{
  final AppRepository? repository;

  GetGasUseCase({this.repository});

  @override
  Future<Either<Failure, EtherAmount>> call(Params params) {
    return repository!.getGas(params.apiUrl!);
  }
}