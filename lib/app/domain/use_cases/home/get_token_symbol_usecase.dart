import 'package:dwallet/app/core/either.dart';
import 'package:dwallet/app/core/failures.dart';
import 'package:dwallet/app/core/use_case.dart';
import 'package:dwallet/app/domain/repository/app_repository.dart';

class GetTokenSymbolUseCase implements UseCase<String,Params>{
  final AppRepository? repository;

  GetTokenSymbolUseCase({this.repository});

  @override
  Future<Either<Failure, String>> call(Params params) {
    return repository!.getTokenSymbol(params.contractAddress!, params.apiUrl!);
  }
}