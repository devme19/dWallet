import 'package:dwallet/app/core/either.dart';
import 'package:dwallet/app/core/failures.dart';
import 'package:dwallet/app/core/use_case.dart';
import 'package:dwallet/app/domain/repository/app_repository.dart';

class GetBalanceUseCase implements UseCase<double,Params>{
  final AppRepository? repository;

  GetBalanceUseCase({this.repository});

  @override
  Future<Either<Failure, double>> call(Params params) {
    return repository!.getBalance(params.value!);
  }
}