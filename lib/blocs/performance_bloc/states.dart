import 'package:equatable/equatable.dart';

/// States emitted by [LogibBloc]
abstract class PerformanceState extends Equatable {

  const PerformanceState();

  @override
  List<Object> get props => [];
}

/// Action required (authentication or registration)
class PerformanceInitial extends PerformanceState {
  const PerformanceInitial();
}

/// Login request awaiting for response
class PerformanceCpu extends PerformanceState {
  final List<List<dynamic>> chartCpu;
  const PerformanceCpu(this.chartCpu);

  @override
  List<Object> get props => [chartCpu];
}
