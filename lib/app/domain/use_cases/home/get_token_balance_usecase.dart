import 'package:dwallet/app/core/either.dart';
import 'package:dwallet/app/core/failures.dart';
import 'package:dwallet/app/domain/repository/app_repository.dart';

import '../../../core/use_case.dart';

class GetTokenBalanceUseCase implements UseCase<BigInt,Params>{
  final AppRepository? repository;

  GetTokenBalanceUseCase({this.repository});

  @override
  Future<Either<Failure, BigInt>> call(Params params) {
    return repository!.getTokenBalance(params.contractAddress!,params.apiUrl!);
  }
}