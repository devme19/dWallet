import 'dart:convert';

import 'package:dwallet/app/data/models/coin_historical_data_model.dart';

class CoinModel {
  String? name;
  String? symbol;
  String? coingeckoId;
  String? chainId;
  List<String>? jrpcApi;
  // List<String>? jrpcApiTest;
  String? imageUrl;
  double? balance=0;
  CoinHistoricalDataModel? historicalData;
  String? contractAddress;
  bool? enable=true;

  double? usd = 0.0;
  double? usdMarketCap;
  double? usd24hVol;
  double? usd24hChange;
  int? lastUpdatedAt;

  CoinModel(
      {
        this.name,
        this.symbol,
        this.coingeckoId,
        this.contractAddress,
        this.chainId,
        this.jrpcApi,
        this.imageUrl,
        this.usd,
        this.usdMarketCap,
        this.usd24hVol,
        this.usd24hChange,
        this.lastUpdatedAt,
        this.enable = true
      });
  CoinModel.fromJson2(Map<String, dynamic> json) {
    usd = json['usd'];
    usdMarketCap = json['usd_market_cap'];
    usd24hVol = json['usd_24h_vol'];
    usd24hChange = json['usd_24h_change'];
    lastUpdatedAt = json['last_updated_at'];
  }
  CoinModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    symbol = json['symbol'];
    coingeckoId = json['coingeckoId'];
    chainId = json['chainId'];
    jrpcApi = json['jrpcApi'].cast<String>();
    // jrpcApiTest = json['jrpcApiTest'].cast<String>();
    imageUrl = json['imageUrl'];
    enable = json['enable'];
  }

  static Map<String, dynamic> toMap(CoinModel coin) =>{
    'name' : coin.name,
    'symbol' : coin.symbol,
    'coingeckoId' : coin.coingeckoId,
    'chainId' : coin.chainId,
    'jrpcApi' : coin.jrpcApi!.cast<String>(),
    'imageUrl' : coin.imageUrl,
    'usd' : coin.usd,
    'usd_market_cap' : coin.usdMarketCap,
    'usd_24h_vol' : coin.usd24hVol,
    'usd_24h_change' : coin.usd24hChange,
    'last_updated_at' : coin.lastUpdatedAt,
    'enable':coin.enable
  };
  static String encode(List<CoinModel> coins) => json.encode(
    coins
        .map<Map<String, dynamic>>((coin) => CoinModel.toMap(coin))
        .toList(),
  );
  static List<CoinModel> decode(String coins) =>
      (json.decode(coins) as List<dynamic>)
          .map<CoinModel>((item) => CoinModel.fromJson(item))
          .toList();
}
