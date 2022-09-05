import 'package:dwallet/app/domain/use_cases/home/get_balance_usecase.dart';
import 'package:dwallet/app/domain/use_cases/home/get_coins_info_usecase.dart';
import 'package:dwallet/app/domain/use_cases/home/get_eth_address_usecase.dart';
import 'package:dwallet/app/domain/use_cases/home/get_historical_data_usecase.dart';
import 'package:dwallet/app/domain/use_cases/home/get_token_balance_usecase.dart';
import 'package:dwallet/app/domain/use_cases/home/get_token_market_info.dart';
import 'package:dwallet/app/domain/use_cases/home/get_token_name_usecase.dart';
import 'package:dwallet/app/domain/use_cases/home/save_coin_to_local_usecase.dart';
import 'package:dwallet/app/domain/use_cases/home/send_transaction_usecase.dart';
import 'package:dwallet/app/domain/use_cases/private_key/save_private_key_usecase.dart';
import 'package:dwallet/app/domain/use_cases/setting/language/set_language_use_case.dart';
import 'package:dwallet/app/domain/use_cases/setting/security/get_passcode_usecase.dart';
import 'package:dwallet/app/domain/use_cases/setting/security/set_passcode_usecase.dart';
import 'package:dwallet/app/domain/use_cases/setting/theme/get_theme_mode_use_case.dart';
import 'package:dwallet/app/domain/use_cases/setting/theme/set_theme_mode_use_case.dart';
import 'package:dwallet/app/presantation/controllers/setting_controller.dart';
import 'package:dwallet/app/presantation/controllers/wallet_controller.dart';
import 'package:get/get.dart';

import '../../data/data_sources/local/local_data_source.dart';
import '../../data/data_sources/remote/remote_data_source.dart';
import '../../data/repository/app_repository_impl.dart';
import '../../domain/repository/app_repository.dart';
import '../../domain/use_cases/home/get_coins_from_local_usecase.dart';
import '../../domain/use_cases/home/get_gas_usecase.dart';
import '../../domain/use_cases/home/get_token_info_by_contract_address_usecase.dart';
import '../../domain/use_cases/home/get_token_decimal_usecase.dart';
import '../../domain/use_cases/home/get_token_symbol_usecase.dart';
import '../../domain/use_cases/home/save_eth_address_usecase.dart';
import '../../domain/use_cases/private_key/get_private_key_usecase.dart';
import '../../domain/use_cases/setting/language/get_language_use_case.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AppLocalDataSource>(AppLocalDateSourceImpl());
    Get.put<AppRemoteDataSource>(AppRemoteDataSourceImpl());
    Get.put<AppRepository>(AppRepositoryImpl(
        localDataSource: Get.find<AppLocalDataSource>(),
        remoteDataSource: Get.find<AppRemoteDataSource>()));
    Get.put<SetLanguageUseCase>(SetLanguageUseCase(
        repository:Get.find<AppRepository>()
    ));
    Get.put<GetLanguageUseCase>(GetLanguageUseCase(
        repository:Get.find<AppRepository>()
    ));
    Get.put<SetThemeModeUseCase>(SetThemeModeUseCase(
      repository:Get.find<AppRepository>()
    ));
    Get.put<GetThemeModeUseCase>(GetThemeModeUseCase(
        repository:Get.find<AppRepository>()
    ));
    Get.put<SettingController>(SettingController());
    Get.put<GetPassCodeUseCase>(
        GetPassCodeUseCase(repository: Get.find<AppRepository>()));
    Get.put<SetPassCodeUseCase>(
        SetPassCodeUseCase(repository: Get.find<AppRepository>()));
    Get.put<GetLanguageUseCase>(
        GetLanguageUseCase(repository: Get.find<AppRepository>()));
    Get.put<GetThemeModeUseCase>(
        GetThemeModeUseCase(repository: Get.find<AppRepository>()));
    Get.put<SavePrivateKeyUseCase>(
        SavePrivateKeyUseCase(repository: Get.find<AppRepository>()));
    Get.put<GetPrivateKeyUseCase>(
        GetPrivateKeyUseCase(repository: Get.find<AppRepository>()));
    Get.put<GetCoinInfoUseCase>(
        GetCoinInfoUseCase(repository: Get.find<AppRepository>()));
    Get.put<GetBalanceUseCase>(
        GetBalanceUseCase(repository: Get.find<AppRepository>()));
    Get.put<GetHistoricalDataUseCase>(
        GetHistoricalDataUseCase(repository: Get.find<AppRepository>()));
    Get.put<GetTokenNameUseCase>(
        GetTokenNameUseCase(repository: Get.find<AppRepository>()));
    Get.put<GetTokenSymbolUseCase>(
        GetTokenSymbolUseCase(repository: Get.find<AppRepository>()));
    Get.put<GetTokenDecimalUseCase>(
        GetTokenDecimalUseCase(repository: Get.find<AppRepository>()));
    Get.put<GetTokenInfoByContractAddressUseCase>(
        GetTokenInfoByContractAddressUseCase(repository: Get.find<AppRepository>()));
    Get.put<GetTokenBalanceUseCase>(
        GetTokenBalanceUseCase(repository: Get.find<AppRepository>()));
    Get.put<SaveEthAddressUseCase>(
        SaveEthAddressUseCase(repository: Get.find<AppRepository>()));
    Get.put<GetEthAddressUseCase>(
        GetEthAddressUseCase(repository: Get.find<AppRepository>()));
    Get.put<GetCoinsFromLocalUseCase>(
        GetCoinsFromLocalUseCase(repository: Get.find<AppRepository>()));
    Get.put<SaveCoinsToLocalUseCase>(
        SaveCoinsToLocalUseCase(repository: Get.find<AppRepository>()));
    Get.put<SendTransactionUseCase>(
        SendTransactionUseCase(repository: Get.find<AppRepository>()));
    Get.put<GetTokenMarketInfoUseCase>(
        GetTokenMarketInfoUseCase(repository: Get.find<AppRepository>()));
    Get.put<GetGasUseCase>(
        GetGasUseCase(repository: Get.find<AppRepository>()));
    Get.put<WalletController>(WalletController());

  }
}