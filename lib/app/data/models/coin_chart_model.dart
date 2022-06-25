class CoinChartModel {
  List<List> prices;
  List<List> marketCaps;
  List<List> totalVolumes;

  CoinChartModel({this.prices, this.marketCaps, this.totalVolumes});

  CoinChartModel.fromJson(Map<String, dynamic> json) {
    if (json['prices'] != null) {
      prices = new List<List>();
      json['prices'].forEach((v) { prices.add(new List.fromJson(v)); });
    }
    if (json['market_caps'] != null) {
      marketCaps = new List<List>();
      json['market_caps'].forEach((v) { marketCaps.add(new List.fromJson(v)); });
    }
    if (json['total_volumes'] != null) {
      totalVolumes = new List<List>();
      json['total_volumes'].forEach((v) { totalVolumes.add(new List.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.prices != null) {
      data['prices'] = this.prices.map((v) => v.toJson()).toList();
    }
    if (this.marketCaps != null) {
      data['market_caps'] = this.marketCaps.map((v) => v.toJson()).toList();
    }
    if (this.totalVolumes != null) {
      data['total_volumes'] = this.totalVolumes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Prices {


  Prices({});

Prices.fromJson(Map<String, dynamic> json) {
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  return data;
}
}
