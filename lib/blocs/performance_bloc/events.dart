import 'package:equatable/equatable.dart';


abstract class PerformanceEvent extends Equatable {
  final List<dynamic> chartCpu;
  final List<dynamic> chartRam;
  final List<dynamic> chartDiskRead;
  final List<dynamic> chartDiskWrite;
  final List<dynamic> chartNetworkInComing;
  final List<dynamic> chartNetworkOutGoing;
  const PerformanceEvent({this.chartCpu=const [],this.chartRam=const [],this.chartDiskRead=const [],this.chartDiskWrite=const [],this.chartNetworkInComing=const [],this.chartNetworkOutGoing=const []});

  @override
  List<Object> get props => [chartCpu,chartRam,chartDiskRead,chartDiskWrite,chartNetworkOutGoing,chartNetworkInComing];
}


class ChartDownloadEvent extends PerformanceEvent {
  const ChartDownloadEvent(List<dynamic> chartCpu,List<dynamic> chartRam,List<dynamic> chartDiskRead,List<dynamic> chartDiskWrite,List<dynamic> chartNetworkInComing,List<dynamic> chartNetworkOutGoing)
      : super(chartCpu:chartCpu,chartRam: chartRam,chartDiskRead: chartDiskRead,chartDiskWrite: chartDiskWrite,chartNetworkOutGoing: chartNetworkOutGoing,chartNetworkInComing: chartNetworkInComing);
}
