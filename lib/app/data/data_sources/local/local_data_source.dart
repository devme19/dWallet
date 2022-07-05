import 'package:dwallet/app/core/exception.dart';
import 'package:dwallet/app/data/models/coin_model.dart';
import 'package:encrypt/encrypt.dart';
import 'package:get_storage/get_storage.dart';

abstract class AppLocalDataSource {
  String getProfile();
  bool saveProfile(String profile);
  bool saveToken(String token);
  String getToken();
  bool saveRefreshToken(String refreshToken);
  String getRefreshToken();
  Future<bool> login(String userName, String password);
  bool setThemeMode(bool isDark);
  bool getThemeMode();
  bool setLanguage(bool isEn);
  bool getLanguage();

  bool savePrivateKey(String key);
  String getPrivateKey();
  bool saveEthereumAddress(String key);
  String getEthereumAddress();
  List<CoinModel> getCoins();
  bool saveCoins(String coins);
}

class AppLocalDateSourceImpl implements AppLocalDataSource {
  GetStorage box = GetStorage();
  String profileKey = "profileKey";
  String tokenKey = "tokenKey";
  String refreshTokenKey = "refreshTokenKey";
  String themeKey = "themeKey";
  String langKey = "langKey";
  String privateKey = "privateKey";
  String ethKey = "ethKey";
  String coinsKey = "coinsKey";
  String defaultCoins = "defaultCoins";
  final _key = Key.fromUtf8('my 32 length key................');
  final _iv = IV.fromLength(16);
  Encrypter? encrypter;
  Encrypted? encrypted;
  @override
  String getProfile() {
    try {
      return box.read(profileKey);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  bool saveProfile(String profile) {
    try {
      box.write(profileKey, profile);
      return true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  String getToken() {
    try {
      return box.read(tokenKey);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  bool saveToken(String token) {
    try {
      box.write(tokenKey, token);
      return true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  String getRefreshToken() {
    try {
      return box.read(refreshTokenKey);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  bool saveRefreshToken(String refreshToken) {
    try {
      box.write(tokenKey, refreshToken);
      return true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<bool> login(String userName, String passWord) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      if (userName == "123" && passWord == "123") {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  bool setThemeMode(bool isDark) {
    try {
      box.write(themeKey, isDark);
      return true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  bool getThemeMode() {
    try {
      return box.read(themeKey) ?? false;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  bool getLanguage() {
    try {
      return box.read(langKey) ?? true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  bool setLanguage(bool isEn) {
    try {
      box.write(langKey, isEn);
      return true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  String getPrivateKey() {
    try {
      // String enc = box.read(privateKey);
      // String decrypted = encrypter!.decrypt(enc, iv: iv).toString();
      return box.read(privateKey) ?? "";
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  bool savePrivateKey(String key) {

    // encrypted = encrypter!.encrypt(key, iv: _iv);
    try {
      box.write(privateKey, key);
      return true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  String getEthereumAddress() {
    try {
      return box.read(ethKey) ?? "";
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  bool saveEthereumAddress(String key) {
    try {
      box.write(ethKey, key);
      return true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  List<CoinModel> getCoins() {
    try {
      String coinsStr = box.read(coinsKey) ?? "";
      List<CoinModel> coins = CoinModel.decode(coinsStr);
      return coins;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  bool saveCoins(String coins) {
    try {
      box.write(coinsKey, coins);
      return true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }


}
