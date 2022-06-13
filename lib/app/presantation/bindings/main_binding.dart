import 'package:dwallet/app/domain/use_cases/setting/theme/get_theme_mode_use_case.dart';
import 'package:dwallet/app/presantation/controllers/setting_controller.dart';
import 'package:get/get.dart';

import '../../data/data_sources/local/local_data_source.dart';
import '../../data/data_sources/remote/remote_data_source.dart';
import '../../data/repository/app_repository_impl.dart';
import '../../domain/repository/app_repository.dart';
import '../../domain/use_cases/setting/language/get_language_use_case.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AppLocalDataSource>(AppLocalDateSourceImpl());
    Get.put<AppRemoteDataSource>(AppRemoteDataSourceImpl());
    Get.put<AppRepository>(AppRepositoryImpl(
        localDataSource: Get.find<AppLocalDataSource>(),
        remoteDataSource: Get.find<AppRemoteDataSource>()));
    Get.put<GetLanguageUseCase>(
        GetLanguageUseCase(repository: Get.find<AppRepository>()));
    Get.put<GetThemeModeUseCase>(
        GetThemeModeUseCase(repository: Get.find<AppRepository>()));
  }
}
