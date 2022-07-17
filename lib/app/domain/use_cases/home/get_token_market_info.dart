import 'package:dwallet/app/core/either.dart';
import 'package:dwallet/app/core/failures.dart';
import 'package:dwallet/app/core/use_case.dart';
import 'package:dwallet/app/data/models/coin_info_model.dart';
import 'package:dwallet/app/domain/repository/app_repository.dart';

class GetTokenMarketInfoUseCase implements UseCase<CoinInfoModel,Params>{
  final AppRepository? repository;

  GetTokenMarketInfoUseCase({this.repository});

  @override
  Future<Either<Failure, CoinInfoModel>> call(Params params) {
    return repository!.getTokenMarketInfo(params.body!, params.id!);
  }
}
