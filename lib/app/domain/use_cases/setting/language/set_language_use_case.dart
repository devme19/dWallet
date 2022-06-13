import 'package:dwallet/app/core/either.dart';
import 'package:dwallet/app/core/failures.dart';
import 'package:dwallet/app/core/use_case.dart';
import 'package:dwallet/app/domain/repository/app_repository.dart';

class SetLanguageUseCase implements UseCase<bool, Params> {
  final AppRepository? repository;

  SetLanguageUseCase({this.repository});

  @override
  Future<Either<Failure, bool>> call(Params params) {
    return repository!.setLanguage(params.boolValue!);
  }
}
