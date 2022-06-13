import 'package:dwallet/app/core/either.dart';
import 'package:dwallet/app/core/failures.dart';
import 'package:dwallet/app/core/use_case.dart';
import 'package:dwallet/app/data/models/verification_model.dart';
import 'package:dwallet/app/domain/repository/app_repository.dart';

class VerificationUseCase implements UseCase<VerificationModel, Params> {
  final AppRepository repository;

  VerificationUseCase({required this.repository});

  @override
  Future<Either<Failure, VerificationModel>> call(Params params) {
    return repository.verification(params.body!);
  }
}
