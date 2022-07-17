import 'package:dwallet/app/data/models/coin_historical_data_model.dart';
import 'package:dwallet/app/data/models/coin_model.dart';
import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../controllers/wallet_controller.dart';
class CoinInfoPage extends GetView<WalletController> {
  CoinModel? coin;
  CoinInfoPage({Key? key,this.coin}) : super(key: key){
    _tooltipBehavior = TooltipBehavior(enable: true);
    controller.getTokenMarketInfo(coin!.coingeckoId!);
  }
  TooltipBehavior? _tooltipBehavior;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var f = NumberFormat('#,###,000', 'en_US');
    print(f.format(12.345));
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.033),
      height: size.height * 0.9,
      decoration: BoxDecoration(
          color: IColor().DARK_BG_COLOR,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: 
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: IColor().DARK_TEXT_COLOR),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: ()=>Get.back(),
                    child: Text(
                      "Back",
                      style:
                      TextStyle(fontSize: 20, color: IColor().DARK_PRIMARY_COLOR),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    coin!.name!,
                    textAlign: TextAlign.center,
                    style: Themes.dark.textTheme.headline1,
                  ),
                ),
                Expanded(child: Container())

              ],
            ),
            coin!.historicalData!= null?
            Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Color(0xffFFD60A).withOpacity(0.1), Colors.black26])),
                width: double.infinity,
                height: 200,
                child:
                SfCartesianChart(
                    primaryXAxis: CategoryAxis(isVisible: false,),
                    primaryYAxis: CategoryAxis(isVisible: false),
                    tooltipBehavior: _tooltipBehavior,
                    plotAreaBorderColor: Colors.transparent,

                    series: <ChartSeries<Point, String>>[
                      LineSeries<Point, String>(
                          width: 1,
                          color: Colors.yellow,
                          enableTooltip: true,
                          dataSource:
                          // asd,
                          coin!.historicalData!.points,
                          xValueMapper: (Point point, _) => point.date.toString(),
                          yValueMapper: (Point point, _) => point.price,
                          // Enable data label
                          dataLabelSettings: const DataLabelSettings(isVisible: false))
                    ]
                )
            ):Container(),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (){

                  },
                    child: Text('1H')),
                InkWell(
                    onTap: (){

                    },
                    child: Text('1D')),
                InkWell(
                    onTap: (){

                    },
                    child: Text('1W')),
                InkWell(
                    onTap: (){

                    },
                    child: Text('1M')),
                InkWell(
                    onTap: (){

                    },
                    child: Text('1Y')),
                InkWell(
                    onTap: (){

                    },
                    child: Text('ALL')),
              ],
            ),
            SizedBox(height: 16.0),
            Divider(height: 15,),
            item(title: 'Website',value: 'technology',hasIcon: true),
            item(title: 'Explorer',value: 'technology.com',hasIcon: true),
            SizedBox(height: 16.0),
            item(title: 'Market Cap',value: '\$${f.format(1123233415)}',),
            item(title: 'Volume(24h)',value: '\$${f.format(878854)}'),
            item(title: 'Circulating Supply',value: '\$${f.format(878854)}'),
          ],
        ),
      ),
    );
  }
  Widget item({String? title, String? value, bool? hasIcon=false}){
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: IColor().DARK_BUTTOM_COLOR.withOpacity(0.1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title!,
            style: TextStyle(fontSize: 18),
          ),
          Row(
            children: [

              Text(
                value!,
                style: TextStyle(
                    color:
                    IColor().DARK_TEXT_COLOR.withOpacity(0.5),
                    fontSize: 18),
              ),
              hasIcon!?
              Icon(
                Icons.arrow_forward,
                color: IColor().DARK_TEXT_COLOR.withOpacity(0.5),
                size: 20,
              ):Container()
            ],
          )
        ],
      ),
    );
  }
}
