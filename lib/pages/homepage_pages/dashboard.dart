import 'package:app_sangfor/api/api_call/dashboard_apicall.dart';
import 'package:app_sangfor/styles.dart';
import 'package:app_sangfor/widgets/reusable_widgets/Indicator.dart';
import 'package:app_sangfor/widgets/reusable_widgets/drawer_menu.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Landing page shown on successful authentication.
class DashBoard extends StatefulWidget {
  const DashBoard();

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _touchedIndex = -1;
  final _dashboard_apicall = const DashBoard_ApiCall();
  late Future<List<double>> _listStatusVM;

  @override
  void initState() {
    super.initState();
    _listStatusVM = _dashboard_apicall.loadDashBoard(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
        appBar: AppBar(
          title: Text("DashBoard"),
          backgroundColor: AppColors.appBarColor,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                _listStatusVM = _dashboard_apicall.loadDashBoard(context);
                setState(() => {});
              },
            )
          ],
        ),
        drawer: DrawerMenu(),
        body: FutureBuilder<List<double>>(
            future: _listStatusVM,
            builder: (context, snapshot) {
              //adding connectionState i'm sure when i press the refresh button to show the circular progress bar
              // because after set state the hasData and hasError aren't reset until the response is back
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                final data = snapshot.data;
                return AspectRatio(
                  aspectRatio: 1.2,
                  child: Card(
                    color: AppColors.appBackgroundColor,
                    elevation: 0,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Virtual Machines",
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.bold,color: Colors.white),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Indicator(
                                  color: const Color(0xff145663),
                                  text: 'Running',
                                  isSquare: false,
                                  //size: touchedIndex == 0 ? 18 : 16,
                                  textColor: _touchedIndex == 0
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                                Indicator(
                                  color: const Color(0xfff8b250),
                                  text: 'Shutdown',
                                  isSquare: false,
                                  //size: touchedIndex == 1 ? 18 : 16,
                                  textColor: _touchedIndex == 1
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Indicator(
                                  color: const Color(0xff845bef),
                                  text: 'Suspended',
                                  isSquare: false,
                                  //size: touchedIndex == 2 ? 18 : 16,
                                  textColor: _touchedIndex == 2
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                                Indicator(
                                  color: const Color(0xff13d38e),
                                  text: 'Crashed',
                                  isSquare: false,
                                  //size: touchedIndex == 3 ? 18 : 16,
                                  textColor: _touchedIndex == 3
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(height:18),
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: PieChart(
                              PieChartData(
                                  pieTouchData: PieTouchData(
                                      touchCallback: (pieTouchResponse) {
                                    setState(() {
                                      final desiredTouch =
                                          pieTouchResponse.touchInput
                                                  is! PointerExitEvent &&
                                              pieTouchResponse.touchInput
                                                  is! PointerUpEvent;
                                      if (desiredTouch &&
                                          pieTouchResponse.touchedSection !=
                                              null) {
                                        _touchedIndex = pieTouchResponse
                                            .touchedSection!
                                            .touchedSectionIndex;
                                      } else {
                                        _touchedIndex = -1;
                                      }
                                    });
                                  }),
                                  borderData: FlBorderData(
                                    show: false,
                                  ),
                                  sectionsSpace: 0,
                                  startDegreeOffset: 90,
                                  centerSpaceRadius: 50,
                                  sections: _showingSections(data!)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (snapshot.hasError &&
                  snapshot.connectionState == ConnectionState.done) {
                return Center(child: Text("No Data!"));
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }

  List<PieChartSectionData> _showingSections(List<double> listStatusVM) {
    return List.generate(4, (i) {
      final isTouched = i == _touchedIndex;
      final double fontSize = isTouched ? 25 : 17;
      final double radius = isTouched ? 60 : 50;
      //the if statement is necessary because the zero value isn't permitted by the Chart Package
      switch (i) {
        case 0:
          return (listStatusVM[0]== 0.0) ? PieChartSectionData(value: 0.001, title: '',radius: radius,color: const Color(0xff0293ee)) :PieChartSectionData(
            color: const Color(0xff145663),
            value: listStatusVM[0],
            title: listStatusVM[0].toString().replaceAll(".0", ""),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return (listStatusVM[1]== 0.0) ? PieChartSectionData(value: 0.001, title: '',radius: radius,color: const Color(0xfff8b250)) : PieChartSectionData(
            color: const Color(0xfff8b250),
            value: listStatusVM[1],
            title: listStatusVM[1].toString().replaceAll(".0", ""),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return (listStatusVM[2]== 0.0) ? PieChartSectionData(value: 0.001, title: '',radius: radius,color: const Color(0xff845bef)) : PieChartSectionData(
            color: const Color(0xff845bef),
            value: listStatusVM[2],
            title: listStatusVM[2].toString().replaceAll(".0", ""),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return (listStatusVM[3]== 0.0) ? PieChartSectionData(value: 0.001, title: '',radius: radius,color: const Color(0xff13d38e)) : PieChartSectionData(
            color: const Color(0xff13d38e),
            value: listStatusVM[3],
            title: listStatusVM[2].toString().replaceAll(".0", ""),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return PieChartSectionData();
      }
    });
  }
}
