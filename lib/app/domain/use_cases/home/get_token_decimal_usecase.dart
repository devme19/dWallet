import 'package:dwallet/app/core/either.dart';
import 'package:dwallet/app/core/failures.dart';
import 'package:dwallet/app/core/use_case.dart';
import 'package:dwallet/app/domain/repository/app_repository.dart';

class GetTokenDecimalUseCase implements UseCase<String,Params>{
  final AppRepository? repository;

  GetTokenDecimalUseCase({this.repository});

  @override
  Future<Either<Failure, String>> call(Params params) {
    return repository!.getTokenDecimal(params.contractAddress!, params.apiUrl!);
  }
}