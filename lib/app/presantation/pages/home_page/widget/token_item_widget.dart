import 'package:dwallet/app/data/models/coin_historical_data_model.dart';
import 'package:dwallet/app/presantation/controllers/wallet_controller.dart';
import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../data/models/coin_model.dart';
import 'package:get/get.dart';

class TokenItemWidget extends StatelessWidget {
  TooltipBehavior? _tooltipBehavior;
  TokenItemWidget({
    Key? key,
    this.coin,
  }) : super(key: key){
    _tooltipBehavior = TooltipBehavior(enable: true);
    // if(coin!.balance==null || coin!.balance ==0.0) {
    //   controller.getBalance(coin!.jrpcApi![0],coin!);
    // }
    // if(coin!.historicalData == null){
    //   controller.getHistoricalData(coin: coin,id: coin!.coingeckoId,currency: 'usd',days: 256,interval: 'daily');
    // }
  }
  CoinModel? coin;
  // List<charts.Series<Point, int>> seriesList=[];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletController>(builder: (controller){
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5,),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: IColor().DARK_BG_COLOR),
        height: 160,
        child:
        Column(children: [

          Expanded(
            child: Row(
              children: [

                Expanded(
                  child:
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.center,
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          // color: const Color(0xffF7931A)
                        ),
                        child:coin!.imageUrl!.isEmpty?Image.asset('assets/images/crypto.png'): Image.network(coin!.imageUrl!),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              coin!.name!,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(coin!.usd!=null?coin!.usd!.toString():""),
                          )
                        ],)
                    ],
                  ),
                ),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: IColor().Dark_CHECK_COLOR.withOpacity(0.2),
                      ),
                      child:
                      Text(
                        'hightPrice!',
                        style: TextStyle(color: IColor().Dark_CHECK_COLOR),
                      ),
                    ),
                  ],
                ),
              ],),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Row(
                          children: [
                            Text(coin!.balance.toString() + ' '+ coin!.symbol!),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '\$${(coin!.balance!*coin!.usd!).toStringAsFixed(2)}',
                              style: Themes.dark.textTheme.headline1,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    coin!.historicalData!= null?
                    Expanded(
                      child:
                      SizedBox(
                          width: 100,
                          height: 300,
                          child:
                          SfCartesianChart(
                              primaryXAxis: CategoryAxis(isVisible: false,),
                              primaryYAxis: CategoryAxis(isVisible: false),
                              tooltipBehavior: _tooltipBehavior,
                              plotAreaBorderColor: Colors.transparent,

                              series: <ChartSeries<Point, String>>[
                                LineSeries<Point, String>(
                                    width: 0.2,
                                    color: Colors.green,
                                    dataSource:
                                    // asd,
                                    coin!.historicalData!.points,
                                    xValueMapper: (Point point, _) => point.date.toString(),
                                    yValueMapper: (Point point, _) => point.price,
                                    // Enable data label
                                    dataLabelSettings: const DataLabelSettings(isVisible: false))
                              ]
                          )
                        // SfCartesianChart(
                        //     primaryXAxis: CategoryAxis(isVisible: false,),
                        //     primaryYAxis: CategoryAxis(isVisible: false),
                        //     plotAreaBorderColor: Colors.transparent,
                        //
                        //     legend: Legend(isVisible: true),
                        //     // Enable tooltip
                        //     tooltipBehavior: TooltipBehavior(enable: true),
                        //
                        //     series: <ChartSeries<Point, String>>[
                        //       LineSeries<Point, String>(
                        //           dataSource: coin!.historicalData!.points,
                        //           xValueMapper: (Point sales, _) => sales.date.toString(),
                        //           yValueMapper: (Point sales, _) => sales.price,
                        //           name: 'Sales',
                        //           // Enable data label
                        //           dataLabelSettings: DataLabelSettings(isVisible: false))
                        //     ]
                        //     ),
                      ),
                    ):Container(),
                    // charts.LineChart(),
                    // Container(
                    //   padding: const EdgeInsets.all(8.0),
                    //   margin: const EdgeInsets.all(8.0),
                    //   alignment: Alignment.center,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(4),
                    //     color: IColor().Dark_CHECK_COLOR.withOpacity(0.2),
                    //   ),
                    //   child: Text(
                    //     'chart!',
                    //     style: TextStyle(color: IColor().Dark_CHECK_COLOR),
                    //   ),
                    // ),
                  ],
                ),
              ],),
          )
        ],),

      );
    });
  }
}