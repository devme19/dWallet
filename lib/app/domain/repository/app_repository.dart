import 'package:dwallet/app/core/either.dart';
import 'package:dwallet/app/core/failures.dart';
import 'package:dwallet/app/data/models/coin_historical_data_model.dart';
import 'package:dwallet/app/data/models/coin_model.dart';
import 'package:dwallet/app/data/models/verification_model.dart';

abstract class AppRepository {
  ////////////////////// USER ///////////////////////////
  Future<Either<Failure, bool>> login(Map<String, dynamic> body);
  Future<Either<Failure, VerificationModel>> verification(
      Map<String, dynamic> body);
  /////////////////////  SETTING /////////////////////////
  Future<Either<Failure, bool>> setThemeMode(bool isDark);
  Future<Either<Failure, bool>> getThemeMode();
  Future<Either<Failure, bool>> setLanguage(bool isEn);
  Future<Either<Failure, bool>> getLanguage();
  /////////////////////  SPLASH /////////////////////////
  Future<Either<Failure, bool>> savePrivateKey(String key);
  Future<Either<Failure, String>> getPrivateKey();
  /////////////////////  Tokens ///////////////////////////
  Future<Either<Failure, List<CoinModel>>> getTokenInfo(Map<String,dynamic> parameters);
  Future<Either<Failure, double>> getBalance(String apiUrl);
  Future<Either<Failure, String>> sendTransaction(Map<String,dynamic> body);
  Future<Either<Failure, CoinHistoricalDataModel>> getHistoricalData(Map<String,dynamic> parameters);
}
