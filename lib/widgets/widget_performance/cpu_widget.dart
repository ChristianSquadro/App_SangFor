import 'package:app_sangfor/blocs/performance_bloc/states.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CpuWidget extends StatefulWidget {
  const CpuWidget();

  @override
  _CpuState createState() => _CpuState();
}

class _CpuState extends State<CpuWidget> {
  final List<Color> _gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  late List<FlSpot> _coordinates;

  void _loadFlSpot (List<List<dynamic>> chartCpu)
  {
    for(int i=0;i < chartCpu.length;i++)
      _coordinates.add(FlSpot(chartCpu[i][2] as double , i as double));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      builder: (context, state) {

        if (state is PerformanceCpu) {
          _loadFlSpot(state.chartCpu);
        }

        return Stack(
          children: <Widget>[
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
                        right: 18.0, left: 12.0, top: 30, bottom: 12),
                    child: LineChart(
                      LineChartData(
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
                                case 2:
                                  return '40m';
                                case 4:
                                  return '20m';
                                case 6:
                                  return 'now';
                              }
                              return '';
                            },
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
                                case 2:
                                  return '20%';
                                case 4:
                                  return '40%';
                                case 6:
                                  return '60%';
                                case 8:
                                  return '80%';
                                case 10:
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
                        maxX: 6,
                        minY: 0,
                        maxY: 10,
                        lineBarsData: [
                          LineChartBarData(
                            spots: [
                              FlSpot(0, 3),
                              FlSpot(2.6, 2),
                              FlSpot(2.8, 2.1),
                              FlSpot(4.9, 5),
                            ],
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
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                "CPU",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
