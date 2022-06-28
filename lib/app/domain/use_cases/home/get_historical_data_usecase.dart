import 'package:dwallet/app/core/either.dart';
import 'package:dwallet/app/core/failures.dart';
import 'package:dwallet/app/core/use_case.dart';
import 'package:dwallet/app/data/models/coin_historical_data_model.dart';
import 'package:dwallet/app/domain/repository/app_repository.dart';

class GetHistoricalDataUseCase implements UseCase<CoinHistoricalDataModel,Params>{
  final AppRepository? repository;

  GetHistoricalDataUseCase({this.repository});

  @override
  Future<Either<Failure, CoinHistoricalDataModel>> call(Params params) {
    return repository!.getHistoricalData(params.body!);
  }
}