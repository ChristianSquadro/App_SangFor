import 'package:equatable/equatable.dart';


abstract class PerformanceEvent extends Equatable {
  final List<List<dynamic>> chartCpu;
  const PerformanceEvent(this.chartCpu);

  @override
  List<Object> get props => [chartCpu];
}


class PerformanceDownload extends PerformanceEvent {
  const PerformanceDownload(
      {required List<List<dynamic>> chartCpu})
      : super(chartCpu);
}