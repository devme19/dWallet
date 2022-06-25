import 'package:dwallet/app/core/either.dart';
import 'package:dwallet/app/core/failures.dart';
import 'package:dwallet/app/data/models/coin_model.dart';
import 'package:dwallet/app/domain/repository/app_repository.dart';

import '../../../core/use_case.dart';

class GetCoinInfoUseCase implements UseCase<List<CoinModel>,Params>{

  final AppRepository? repository;

  GetCoinInfoUseCase({this.repository});

  @override
  Future<Either<Failure, List<CoinModel>>> call(Params params) {
    return repository!.getTokenInfo(params.body!);
  }

}