import 'package:app_sangfor/blocs/performance_bloc/bloc.dart';
import 'package:app_sangfor/blocs/performance_bloc/states.dart';
import 'package:app_sangfor/widgets/reusable_widgets/Indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResourceTwoLineWidget extends StatefulWidget {
  final String typeResource;

  const ResourceTwoLineWidget(
    this.typeResource,
  );

  @override
  _ResourceTwoLineState createState() => _ResourceTwoLineState(typeResource);
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
  List<FlSpot> _coordinates1 = [];
  List<String> _toolTips1 = [];
  List<FlSpot> _coordinates2 = [];
  List<String> _toolTips2 = [];

  _ResourceTwoLineState(this._typeResource);

  void _loadFlSpot(List<dynamic> chart1, List<dynamic> chart2) {
    int length =
        (chart1.length > chart2.length) ? chart1.length : chart2.length;
    for (int i = 0; i < length; i++) {
      var percentageUtil1 = chart1[i][2] as num;
      var dateUtil1 = chart1[i][0] as String;
      var percentageUtil2 = chart2[i][2] as num;
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
        }

        return Stack(children: <Widget>[
          AspectRatio(
            aspectRatio: 1.60,
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(18),
                  ),
                  color: Color(0xff232d37)),
              child: Padding(
                  padding: const EdgeInsets.only(
                      right: 25.0, left: 12.0, top: 35, bottom: 12),
                  child: LineChart(
                    LineChartData(
                      lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                            tooltipBgColor: Colors.blueAccent,
                            getTooltipItems:
                                (List<LineBarSpot> touchedBarSpots) {
                              return touchedBarSpots.map((barSpot) {
                                final flSpot = barSpot;

                                return LineTooltipItem(
                                  '${(flSpot.barIndex == 0) ? _toolTips1[flSpot.spotIndex] : _toolTips2[flSpot.spotIndex]} \n',
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
                                      text: 'bps',
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
                          getTitles: (value) {
                            switch (value.toInt()) {
                              case 0:
                                return '0bps';
                              case 50:
                                return '50bps';
                              case 100:
                                return '100bps';
                              case 150:
                                return '150bps';
                              case 200:
                                return '200bps';
                            }
                            return '';
                          },
                          reservedSize: 38,
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
                      maxY: 200,
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
                              colors: _gradientColors1
                                  .map((color) => color.withOpacity(0.3))
                                  .toList(),
                            )),
                      ],
                    ),
                  )),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              _typeResource,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          Align(
              alignment: Alignment.bottomLeft,
              child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Indicator(
                    color: const Color(0xff0293ee),
                    text: 'Running',
                    isSquare: false,
                    //size: touchedIndex == 0 ? 18 : 16,
                    //textColor: _touchedIndex == 0 ? Colors.black : Colors.grey,
                  ),
                  Indicator(
                    color: const Color(0xfff8b250),
                    text: 'Shutdown',
                    isSquare: false,
                    //size: touchedIndex == 1 ? 18 : 16,
                    //textColor: _touchedIndex == 1 ? Colors.black : Colors.grey,
                  ),
                ],
              ),
            ],
          ))
        ]);
      },
    );
  }
}
