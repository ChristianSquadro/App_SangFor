import 'dart:io';

import 'states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'events.dart';

/// Manages the login state of the app
class PerformanceBloc extends Bloc<PerformanceEvent, PerformanceState> {

  PerformanceBloc() : super(PerformanceInitial());

  @override
  Stream<PerformanceState> mapEventToState(PerformanceEvent event) async* {
    yield* _performanceDownload(event);
  }

  Stream<PerformanceState> _performanceDownload(PerformanceEvent event) async* {

    if (event is ChartCpuDownload)
      yield PerformanceCpu(event.chartCpu);

    if (event is ChartRamDownload)
      yield PerformanceRam(event.chartRam);

    if (event is ChartDiskDownload)
      yield PerformanceDisk(event.chartDisk);
  }
}
