import 'package:equatable/equatable.dart';


abstract class PerformanceEvent extends Equatable {
  final List<dynamic> chartCpu;
  final List<dynamic> chartRam;
  final List<dynamic> chartDisk;
  const PerformanceEvent({this.chartCpu=const [],this.chartRam=const [],this.chartDisk=const []});

  @override
  List<Object> get props => [chartCpu,chartRam,chartDisk];
}


class ChartCpuDownload extends PerformanceEvent {
  const ChartCpuDownload(List<dynamic> chartCpu)
      : super(chartCpu:chartCpu);
}

class ChartRamDownload extends PerformanceEvent {
  const ChartRamDownload(List<dynamic> chartRam)
      : super(chartRam:chartRam);
}

class ChartDiskDownload extends PerformanceEvent {
  const ChartDiskDownload(List<dynamic> chartDisk)
      : super(chartDisk:chartDisk);
}