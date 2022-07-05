import 'package:dwallet/app/core/either.dart';
import 'package:dwallet/app/core/failures.dart';
import 'package:dwallet/app/domain/repository/app_repository.dart';

import '../../../core/use_case.dart';

class SaveCoinsToLocalUseCase implements UseCase<bool,Params>{
  final AppRepository? repository;

  SaveCoinsToLocalUseCase({this.repository});

  @override
  Future<Either<Failure, bool>> call(Params params) {
    return repository!.saveCoinsToLocal(params.value!);
  }
}