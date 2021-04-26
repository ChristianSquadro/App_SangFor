import 'package:equatable/equatable.dart';


abstract class PerformanceEvent extends Equatable {
  final List<dynamic> chartCpu;
  final List<dynamic> chartRam;
  final List<dynamic> chartDisk;
  const PerformanceEvent({this.chartCpu=const [],this.chartRam=const [],this.chartDisk=const []});

  @override
  List<Object> get props => [chartCpu,chartRam,chartDisk];
}


class ChartDownloadEvent extends PerformanceEvent {
  const ChartDownloadEvent(List<dynamic> chartCpu,List<dynamic> chartRam,List<dynamic> chartDisk)
      : super(chartCpu:chartCpu,chartRam: chartRam,chartDisk: chartDisk);
}
