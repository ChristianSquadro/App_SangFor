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
  int touchedIndex= -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("DashBoard"),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {  },
            )
          ],
        ),
        drawer: DrawerMenu(),
        body: AspectRatio(
          aspectRatio: 1.2,
          child: Card(
            color: Colors.white,
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
                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
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
                          color: const Color(0xff0293ee),
                          text: 'Running',
                          isSquare: false,
                          //size: touchedIndex == 0 ? 18 : 16,
                          textColor:
                              touchedIndex == 0 ? Colors.black : Colors.grey,
                        ),
                        Indicator(
                          color: const Color(0xfff8b250),
                          text: 'Shutdown',
                          isSquare: false,
                          //size: touchedIndex == 1 ? 18 : 16,
                          textColor:
                              touchedIndex == 1 ? Colors.black : Colors.grey,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Indicator(
                          color: const Color(0xff845bef),
                          text: 'Suspended/Pause',
                          isSquare: false,
                          //size: touchedIndex == 2 ? 18 : 16,
                          textColor:
                              touchedIndex == 2 ? Colors.black : Colors.grey,
                        ),
                        Indicator(
                          color: const Color(0xff13d38e),
                          text: 'Crashed',
                          isSquare: false,
                          //size: touchedIndex == 3 ? 18 : 16,
                          textColor:
                              touchedIndex == 3 ? Colors.black : Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(
                          pieTouchData:
                              PieTouchData(touchCallback: (pieTouchResponse) {
                            setState(() {
                              final desiredTouch = pieTouchResponse.touchInput
                                      is! PointerExitEvent &&
                                  pieTouchResponse.touchInput
                                      is! PointerUpEvent;
                              if (desiredTouch &&
                                  pieTouchResponse.touchedSection != null) {
                                touchedIndex = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                              } else {
                                touchedIndex = -1;
                              }
                            });
                          }),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 50,
                          sections: _showingSections()),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  List<PieChartSectionData> _showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 17;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 40,
            title: '40',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 30,
            title: '30',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 15,
            title: '15',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 15,
            title: '15',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return PieChartSectionData(value: 0);
      }
    });
  }
}
