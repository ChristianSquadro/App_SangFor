import 'package:equatable/equatable.dart';


abstract class PerformanceState extends Equatable {
  final List<dynamic> chartCpu;
  final List<dynamic> chartRam;
  final List<dynamic> chartDisk;
  final List<dynamic> chartNetworkInComing;
  final List<dynamic> chartNetworkOutGoing;
  const PerformanceState({this.chartCpu=const [],this.chartRam=const [],this.chartDisk=const [],this.chartNetworkInComing=const [],this.chartNetworkOutGoing=const []});

  @override
  List<Object> get props => [];
}


class PerformanceInitialState extends PerformanceState {
  const PerformanceInitialState() : super ();
}


class PerformanceCpuState extends PerformanceState {
  const PerformanceCpuState(List<dynamic> chartCpu) : super (chartCpu: chartCpu);
}

class PerformanceRamState extends PerformanceState {
  const PerformanceRamState(List<dynamic> chartRam) : super (chartRam: chartRam);
}

class PerformanceDiskState extends PerformanceState {
  const PerformanceDiskState(List<dynamic> chartDisk) : super (chartDisk: chartDisk);
}

class PerformanceNetworkState extends PerformanceState {
  const PerformanceNetworkState(List<dynamic> chartNetworkInComing,List<dynamic> chartNetworkOutGoing) : super (chartNetworkInComing: chartNetworkInComing, chartNetworkOutGoing: chartNetworkOutGoing);
}
