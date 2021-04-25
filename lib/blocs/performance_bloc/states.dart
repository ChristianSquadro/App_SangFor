import 'package:equatable/equatable.dart';


abstract class PerformanceState extends Equatable {
  final List<dynamic> chartCpu;
  final List<dynamic> chartRam;
  final List<dynamic> chartDisk;
  const PerformanceState({this.chartCpu=const [],this.chartRam=const [],this.chartDisk=const []});

  @override
  List<Object> get props => [];
}


class PerformanceInitial extends PerformanceState {
  const PerformanceInitial() : super ();
}


class PerformanceCpu extends PerformanceState {
  const PerformanceCpu(List<dynamic> chartCpu) : super (chartCpu: chartCpu);
}

class PerformanceRam extends PerformanceState {
  const PerformanceRam(List<dynamic> chartRam) : super (chartRam: chartRam);
}

class PerformanceDisk extends PerformanceState {
  const PerformanceDisk(List<dynamic> chartDisk) : super (chartDisk: chartDisk);
}
