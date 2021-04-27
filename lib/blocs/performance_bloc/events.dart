import 'package:equatable/equatable.dart';


abstract class PerformanceEvent extends Equatable {
  final List<dynamic> chartCpu;
  final List<dynamic> chartRam;
  final List<dynamic> chartDisk;
  final List<dynamic> chartNetworkInComing;
  final List<dynamic> chartNetworkOutGoing;
  const PerformanceEvent({this.chartCpu=const [],this.chartRam=const [],this.chartDisk=const [],this.chartNetworkInComing=const [],this.chartNetworkOutGoing=const []});

  @override
  List<Object> get props => [chartCpu,chartRam,chartDisk];
}


class ChartDownloadEvent extends PerformanceEvent {
  const ChartDownloadEvent(List<dynamic> chartCpu,List<dynamic> chartRam,List<dynamic> chartDisk,List<dynamic> chartNetworkInComing,List<dynamic> chartNetworkOutGoing)
      : super(chartCpu:chartCpu,chartRam: chartRam,chartDisk: chartDisk,chartNetworkOutGoing: chartNetworkOutGoing,chartNetworkInComing: chartNetworkOutGoing);
}
