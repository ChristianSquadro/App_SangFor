import 'package:app_sangfor/blocs/performance_bloc/bloc.dart';
import 'package:app_sangfor/blocs/performance_bloc/states.dart';
import 'package:app_sangfor/widgets/reusable_widgets/Indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResourceTwoLineWidget extends StatefulWidget {
  final String typeResource;
  final String measure;
  final String lineDescription1;
  final String lineDescritpion2;
  final double maxY;

  const ResourceTwoLineWidget(this.typeResource, this.measure,
      this.lineDescription1, this.lineDescritpion2, this.maxY);

  @override
  _ResourceTwoLineState createState() => _ResourceTwoLineState(
      typeResource, measure, lineDescription1, lineDescritpion2, maxY);
}

class _ResourceTwoLineState extends State<ResourceTwoLineWidget> {
  final List<Color> _gradientColors1 = const [
    Color(0xff23b6e6),
    Color(0xff02d39a),
  ];
  final List<Color> _gradientColors2 = const [
    Color(0x50aa4cfc),
    Color(0x99aa4cfc),
  ];
  final String _typeResource;
  final String measure;
  final String lineDescription1;
  final String lineDescritpion2;
  final double maxY;

  _ResourceTwoLineState(this._typeResource, this.measure, this.lineDescription1,
      this.lineDescritpion2, this.maxY);

  List<FlSpot> _coordinates1 = [];
  List<String> _toolTips1 = [];
  List<FlSpot> _coordinates2 = [];
  List<String> _toolTips2 = [];

  void _loadFlSpot(List<dynamic> chart1, List<dynamic> chart2) {
    //move inside bloc
    int length =
        (chart1.length > chart2.length) ? chart1.length : chart2.length;
    for (int i = 0; i < length; i++) {
      num percentageUtil1 = 0, percentageUtil2 = 0;
      if (_typeResource == "DISK")
        percentageUtil1 = (chart1[i][2] as num) / 1000000;
      else
        chart1[i][2]=8000000000;
        percentageUtil1 = (chart1[i][2] as num) / 1000000000;
      var dateUtil1 = chart1[i][0] as String;
      if (_typeResource == "DISK")
        percentageUtil2 = (chart2[i][2] as num) / 1000000;
      else
        chart2[i][2]=15000000000;
        percentageUtil2 = (chart2[i][2] as num) / 1000000000;
      var dateUtil2 = chart2[i][0] as String;
      _coordinates1.add(FlSpot(i.toDouble(), percentageUtil1.roundToDouble()));
      _toolTips1.add(dateUtil1.replaceFirst("T", "\n"));
      _coordinates2.add(FlSpot(i.toDouble(), percentageUtil2.roundToDouble()));
      _toolTips2.add(dateUtil2.replaceFirst("T", "\n"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PerformanceBloc, List<PerformanceState>>(
      builder: (context, state) {
        for (int i = 0; i < state.length; i++) {
          if (state[i] is PerformanceNetworkState &&
              _typeResource == "NETWORK") {
            _loadFlSpot(
                state[i].chartNetworkInComing, state[i].chartNetworkOutGoing);
          }

          if (state[i] is PerformanceDiskState && _typeResource == "DISK") {
            _loadFlSpot(state[i].chartDiskRead, state[i].chartDiskWrite);
          }
        }

        return Column(children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              _typeResource,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          Align(
              heightFactor: 1.06,
              child: Stack(alignment: Alignment.bottomCenter, children: [
                Align(
                    child: AspectRatio(
                  aspectRatio: 1.45,
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(18),
                        ),
                        color: Color(0xff232d37)),
                    child: Padding(
                        padding: const EdgeInsets.only(
                            right: 25.0, left: 12.0, top: 35, bottom: 40),
                        child: LineChart(
                          LineChartData(
                            lineTouchData: LineTouchData(
                              touchTooltipData: LineTouchTooltipData(
                                  tooltipBgColor: Colors.cyan,
                                  getTooltipItems:
                                      (List<LineBarSpot> touchedBarSpots) {
                                    return touchedBarSpots.map((barSpot) {
                                      final flSpot = barSpot;

                                      return LineTooltipItem(
                                        '${(flSpot.barIndex == 0) ? lineDescription1+" "+_toolTips1[flSpot.spotIndex] : lineDescritpion2+" "+_toolTips2[flSpot.spotIndex]} \n',
                                        const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: flSpot.y
                                                .toString()
                                                .replaceFirst(".0", ""),
                                            style: TextStyle(
                                              color: Colors.grey[100],
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          TextSpan(
                                            text: measure,
                                            style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList();
                                  }),
                            ),
                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: true,
                              getDrawingHorizontalLine: (value) {
                                return FlLine(
                                  color: const Color(0xff37434d),
                                  strokeWidth: 1,
                                );
                              },
                              getDrawingVerticalLine: (value) {
                                return FlLine(
                                  color: const Color(0xff37434d),
                                  strokeWidth: 1,
                                );
                              },
                            ),
                            titlesData: FlTitlesData(
                              show: true,
                              bottomTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 22,
                                getTextStyles: (value) => const TextStyle(
                                    color: Color(0xff68737d),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                getTitles: (value) {
                                  switch (value.toInt()) {
                                    case 0:
                                      return '60m';
                                    case 20:
                                      return '40m';
                                    case 40:
                                      return '20m';
                                    case 59:
                                      return 'now';
                                  }
                                  return '';
                                },
                                interval: 1,
                                margin: 10,
                              ),
                              leftTitles: SideTitles(
                                showTitles: true,
                                getTextStyles: (value) => const TextStyle(
                                  color: Color(0xff67727d),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                                getTitles: (_typeResource == "NETWORK")
                                    ? (value) {
                                        switch (value.toInt()) {
                                          case 0:
                                            return '0$measure';
                                          case 20:
                                            return '20$measure';
                                          case 40:
                                            return '40$measure';
                                          case 60:
                                            return '60$measure';
                                          case 80:
                                            return '80$measure';
                                          case 100:
                                            return '100$measure';
                                        }
                                        return '';
                                      }
                                    : (value) {
                                        switch (value.toInt()) {
                                          case 0:
                                            return '0$measure';
                                          case 5:
                                            return '5$measure';
                                          case 10:
                                            return '10$measure';
                                          case 15:
                                            return '15$measure';
                                          case 20:
                                            return '20$measure';
                                          case 25:
                                            return '25$measure';
                                        }
                                        return '';
                                      },
                                reservedSize: 48,
                                margin: 12,
                              ),
                            ),
                            borderData: FlBorderData(
                                show: true,
                                border: Border.all(
                                    color: const Color(0xff37434d), width: 1)),
                            minX: 0,
                            maxX: 59,
                            minY: 0,
                            maxY: maxY,
                            lineBarsData: [
                              LineChartBarData(
                                spots: _coordinates1,
                                isCurved: true,
                                colors: _gradientColors1,
                                barWidth: 2,
                                isStrokeCapRound: true,
                                dotData: FlDotData(
                                  show: false,
                                ),
                                belowBarData: BarAreaData(
                                  show: true,
                                  colors: _gradientColors1
                                      .map((color) => color.withOpacity(0.3))
                                      .toList(),
                                ),
                              ),
                              LineChartBarData(
                                  spots: _coordinates2,
                                  isCurved: true,
                                  colors: _gradientColors2,
                                  barWidth: 2,
                                  isStrokeCapRound: true,
                                  dotData: FlDotData(
                                    show: false,
                                  ),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    colors: _gradientColors2
                                        .map((color) => color.withOpacity(0.3))
                                        .toList(),
                                  )),
                            ],
                          ),
                        )),
                  ),
                )),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Indicator(
                          color: const Color(0xff02d39a),
                          text: lineDescription1,
                          isSquare: false,
                        ),
                        Indicator(
                          color: const Color(0x99aa4cfc),
                          text: lineDescritpion2,
                          isSquare: false,
                        ),
                      ],
                    ))
              ]))
        ]);
      },
    );
  }
}
