import 'package:dwallet/app/core/either.dart';
import 'package:dwallet/app/core/failures.dart';
import 'package:dwallet/app/core/use_case.dart';
import 'package:dwallet/app/domain/repository/app_repository.dart';

class GetPrivateKeyUseCase implements UseCase<String,NoParams>{
  final AppRepository? repository;

  GetPrivateKeyUseCase({this.repository});

  @override
  Future<Either<Failure, String>> call(NoParams params) {
    // TODO: implement call
    return repository!.getPrivateKey();
  }
}