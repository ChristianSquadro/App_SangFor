import 'states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'events.dart';

/// Manages the login state of the app
class PerformanceBloc extends Bloc<PerformanceEvent, PerformanceState> {

  PerformanceBloc() : super(PerformanceInitial());

  @override
  Stream<PerformanceState> mapEventToState(PerformanceEvent event) async* {
    if (event is PerformanceDownload) {
      yield* _performanceDownload(event);
    }
  }

  Stream<PerformanceState> _performanceDownload(PerformanceEvent event) async* {
    yield PerformanceCpu(event.chartCpu);
  }
}
