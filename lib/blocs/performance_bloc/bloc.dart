
import 'states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'events.dart';

/// Manages the login state of the app
class PerformanceBloc extends Bloc<PerformanceEvent, List<PerformanceState>> {

  PerformanceBloc() : super([]);

  @override
  Stream<List<PerformanceState>> mapEventToState(PerformanceEvent event) async* {
    yield* _performanceDownload(event);
  }

  Stream<List<PerformanceState>> _performanceDownload(PerformanceEvent event) async* {

    //i have to insert a list because the subscribers aren't ready yet to listen.
    // Sending them one by one, the next state cancels the previous one at every yield sent.
    //So I preferred have a list of states to send just once.
    List<PerformanceState> performanceStates=[];

    performanceStates.add(PerformanceCpuState(event.chartCpu));
    performanceStates.add(PerformanceRamState(event.chartRam));
    performanceStates.add(PerformanceDiskState(event.chartDisk));
    performanceStates.add(PerformanceNetworkState(event.chartNetworkInComing, event.chartNetworkOutGoing));

    yield performanceStates;
  }
}
