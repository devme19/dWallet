import 'dart:convert';

import 'package:dwallet/app/data/models/coin_historical_data_model.dart';

class CoinModel {
  String? name;
  String? symbol;
  String? coingeckoId;
  String? chainId;
  List<String>? jrpcApi;
  String? imageUrl;
  double? balance=0;
  CoinHistoricalDataModel? historicalData;
  String? network;

  bool isSelected = false;

  double? usd;
  double? usdMarketCap;
  double? usd24hVol;
  double? usd24hChange;
  int? lastUpdatedAt;

  CoinModel(
      {this.name,
        this.symbol,
        this.coingeckoId,
        this.chainId,
        this.jrpcApi,
        this.imageUrl,
        this.usd,
        this.usdMarketCap,
        this.usd24hVol,
        this.usd24hChange,
        this.lastUpdatedAt
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
    jrpcApi = jsonEncode(json['jrpcApi']) as List<String>?;
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['symbol'] = symbol;
    data['coingeckoId'] = coingeckoId;
    data['chainId'] = chainId;
    data['jrpcApi'] = jrpcApi!.cast<String>();
    data['imageUrl'] = imageUrl;
    data['usd'] = usd;
    data['usd_market_cap'] = usdMarketCap;
    data['usd_24h_vol'] = usd24hVol;
    data['usd_24h_change'] = usd24hChange;
    data['last_updated_at'] = lastUpdatedAt;
    return data;
  }
}
