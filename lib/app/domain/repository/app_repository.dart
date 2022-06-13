import 'package:dwallet/app/core/either.dart';
import 'package:dwallet/app/core/failures.dart';
import 'package:dwallet/app/data/models/verification_model.dart';

abstract class AppRepository {
  ////////////////////// USER ///////////////////////////
  Future<Either<Failure, bool>> login(Map<String, dynamic> body);
  Future<Either<Failure, VerificationModel>> verification(
      Map<String, dynamic> body);
  ///////////////////// SETTING /////////////////////////
  Future<Either<Failure, bool>> setThemeMode(bool isDark);
  Future<Either<Failure, bool>> getThemeMode();
  Future<Either<Failure, bool>> setLanguage(bool isEn);
  Future<Either<Failure, bool>> getLanguage();
}
