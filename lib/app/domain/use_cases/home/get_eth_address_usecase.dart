import 'package:dwallet/app/core/either.dart';
import 'package:dwallet/app/core/failures.dart';
import 'package:dwallet/app/domain/repository/app_repository.dart';

import '../../../core/use_case.dart';

class GetEthAddressUseCase implements UseCase<String,NoParams>{
  final AppRepository? repository;

  GetEthAddressUseCase({this.repository});

  @override
  Future<Either<Failure, String>> call(NoParams params) {
    return repository!.getEthAddress();
  }
}