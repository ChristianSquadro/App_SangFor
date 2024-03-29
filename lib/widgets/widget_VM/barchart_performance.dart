import 'package:app_sangfor/api/api_call/current_performance_apicall.dart';
import 'package:app_sangfor/api/json_models/listVM/listVM.dart';
import 'package:app_sangfor/styles.dart';
import 'package:flutter/gestures.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarPerformance extends StatefulWidget {
  final Servers vm;

  const BarPerformance(this.vm);

  @override
  BarPerformanceState createState() => BarPerformanceState(vm);
}

class BarPerformanceState extends State<BarPerformance> {
  final Color barBackgroundColor = AppColors.appBackgroundColor;
  final Duration animDuration = const Duration(milliseconds: 250);
  int touchedIndex = -1;
  late Future<List<dynamic>> _currentPerformance;
  final Servers vm;
  List<dynamic>? data;

  BarPerformanceState(this.vm);

  @override
  void initState() {
    super.initState();
    var currentPerformanceApiCall=CurrentPerformanceApiCall();
    _currentPerformance=currentPerformanceApiCall.getPerformanceUtilisation(context, vm.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: _currentPerformance,
        builder: (context, snapshot) {
      //adding connectionState i'm sure when i press the refresh button to show the circular progress bar
      // because after set state the hasData and hasError aren't reset until the response is back
      if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
         data = snapshot.data;

        return AspectRatio(
            aspectRatio: 2.3,
            child: Column(
                children: <Widget>[
                  Flexible(
                    flex:9,
                    child: BarChart(
                      mainBarData(),
                    ),
                  ),
                  Flexible(
                      flex:3,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding:  EdgeInsets.fromLTRB(0, 5, 32,0) ,
                          child: Image(
                            image: AssetImage("assets/cpu.png"),
                            height: 40,
                            width: 40,
                          )),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 15,0),
                          child: Image(
                              image: AssetImage("assets/ram.png"),
                              height: 40,
                              width: 40)),
                      Padding(
                          padding: EdgeInsets.fromLTRB(17, 5,0,0) ,
                          child: Image(
                              image: AssetImage("assets/disk.png"),
                              height: 40,
                              width: 40)),
                    ],
                  )),
                ]));
      }

      if (snapshot.hasError &&
          snapshot.connectionState == ConnectionState.done) {
        return Center(child: Text("No Data!"));
      }

      return Container(height: 200,child: const Center(child:CircularProgressIndicator()));
    });
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.blueGrey,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [barColor] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 100,
            colors: [barBackgroundColor],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(3, (i) {
        switch (i) {
          case 0:
            var tmp=data![0][59][2] as num;
            return makeGroupData(0, tmp.roundToDouble() , isTouched: i == touchedIndex);
          case 1:
            var tmp=data![1][59][2] as num;
            return makeGroupData(1, tmp.roundToDouble(), isTouched: i == touchedIndex);
          case 2:
            var tmp=data![2][59][2] as num;
            return makeGroupData(2, tmp.roundToDouble(), isTouched: i == touchedIndex);
          default:
            throw ArgumentError('Unexpected type for data');
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      alignment: BarChartAlignment.center,
      groupsSpace: 50,
      minY: 0,
      maxY: 100,
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay = "";
              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'Cpu %';
                  break;
                case 1:
                  weekDay = 'Ram %';
                  break;
                case 2:
                  weekDay = 'Disk %';
                  break;
              }
              return BarTooltipItem(
                weekDay + '\n',
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.y - 1).toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! PointerUpEvent &&
                barTouchResponse.touchInput is! PointerExitEvent) {
              touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: false,
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }
}
