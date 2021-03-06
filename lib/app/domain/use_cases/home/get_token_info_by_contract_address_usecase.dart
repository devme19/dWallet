import 'package:dwallet/app/core/either.dart';
import 'package:dwallet/app/core/failures.dart';
import 'package:dwallet/app/core/use_case.dart';
import 'package:dwallet/app/data/models/coin_model.dart';
import 'package:dwallet/app/data/models/token_model.dart';
import 'package:dwallet/app/domain/repository/app_repository.dart';

class GetTokenInfoByContractAddressUseCase implements UseCase<TokenModel,Params>{
  final AppRepository? repository;

  GetTokenInfoByContractAddressUseCase({this.repository});

  @override
  Future<Either<Failure, TokenModel>> call(Params params) {
    return repository!.getTokenInfoByContractAddress(params.contractAddress!, params.assetPlatform!);
  }
}