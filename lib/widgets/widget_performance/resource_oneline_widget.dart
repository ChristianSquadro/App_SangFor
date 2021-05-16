import 'package:app_sangfor/blocs/performance_bloc/bloc.dart';
import 'package:app_sangfor/blocs/performance_bloc/states.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResourceOneLineWidget extends StatefulWidget {
  final String typeResource;

  const ResourceOneLineWidget(this.typeResource,);

  @override
  _ResourceOneLineState createState() => _ResourceOneLineState(typeResource);
}

class _ResourceOneLineState extends State<ResourceOneLineWidget> {
  final List<Color> _gradientColors = const [
    Color(0xff23b6e6),
    Color(0xff02d39a),
  ];
  final String _typeResource;

  _ResourceOneLineState(this._typeResource);

  List<FlSpot> _coordinates=[];
  List<String> _toolTips=[];

  void _loadFlSpot(List<dynamic> chart) {
    //move inside bloc
    for (int i = 0; i < chart.length; i++) {
       var percentageUtil=chart[i][2] as num;
       var dateUtil=chart[i][0] as String;
      _coordinates.add(FlSpot(i.toDouble(), percentageUtil.roundToDouble()));
      _toolTips.add(dateUtil.replaceFirst("T", "\n"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PerformanceBloc, List<PerformanceState>>(
      builder: (context, state) {

        for(int i=0;i< state.length;i++) {
          if (state[i] is PerformanceCpuState && _typeResource == "CPU") {
            _loadFlSpot(state[i].chartCpu);
          }

          if (state[i] is PerformanceRamState && _typeResource == "RAM") {
            _loadFlSpot(state[i].chartRam);
          }
        }

        return Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                _typeResource,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            Align(
              heightFactor: 1.06,
                child:
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
                              tooltipBgColor: Colors.cyan,
                              getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                                return touchedBarSpots.map((barSpot) {
                                  final flSpot = barSpot;

                                  return LineTooltipItem(
                                    '${_toolTips[flSpot.spotIndex]} \n',
                                    const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: flSpot.y.toString().replaceFirst(".0", ""),
                                        style: TextStyle(
                                          color: Colors.grey[100],
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '%',
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
                              fontSize: 15,
                            ),
                            getTitles: (value) {
                              switch (value.toInt()) {
                                case 0:
                                  return '0%';
                                case 20:
                                  return '20%';
                                case 40:
                                  return '40%';
                                case 60:
                                  return '60%';
                                case 80:
                                  return '80%';
                                case 100:
                                  return '100%';
                              }
                              return '';
                            },
                            reservedSize: 32,
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
                        maxY: 100,
                        lineBarsData: [
                          LineChartBarData(
                            spots: _coordinates,
                            isCurved: true,
                            colors: _gradientColors,
                            barWidth: 2,
                            isStrokeCapRound: true,
                            dotData: FlDotData(
                              show: false,
                            ),
                            belowBarData: BarAreaData(
                              show: true,
                              colors: _gradientColors
                                  .map((color) => color.withOpacity(0.3))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            )),
          ],
        );
      },
    );
  }
}
