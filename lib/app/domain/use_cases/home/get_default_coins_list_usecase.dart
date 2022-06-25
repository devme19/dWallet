import 'package:dwallet/app/core/either.dart';
import 'package:dwallet/app/core/failures.dart';
import 'package:dwallet/app/data/models/coin_model.dart';
import 'package:dwallet/app/domain/repository/app_repository.dart';

import '../../../core/use_case.dart';

class GetDefaultCoinsListUseCase implements UseCase<List<CoinModel>,NoParams>{
  final AppRepository? repository;

  GetDefaultCoinsListUseCase({this.repository});

  @override
  Future<Either<Failure, List<CoinModel>>> call(NoParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}