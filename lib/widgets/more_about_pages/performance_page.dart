import 'dart:io';

import 'package:app_sangfor/api/api_call/performance_apicall.dart';
import 'package:app_sangfor/blocs/performance_bloc/bloc.dart';
import 'package:app_sangfor/blocs/performance_bloc/events.dart';
import 'package:app_sangfor/cache/Vm_Cache.dart';
import 'package:app_sangfor/widgets/widget_performance/resource_oneline_widget.dart';
import 'package:app_sangfor/widgets/widget_performance/resource_twoline_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class PerformancePage extends StatefulWidget {
  const PerformancePage();

  @override
  _PerformanceState createState() => _PerformanceState();
}

class _PerformanceState extends State<PerformancePage> {
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  late final PerformanceVM_ApiCall performanceVM;
  late Future<List<dynamic>> listCpuUtil;

  @override
  void initState() {
    super.initState();
    performanceVM = PerformanceVM_ApiCall();
    listCpuUtil = performanceVM.getChartUtilisation(
        context, Provider.of<VmCache>(context, listen: false).idServer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider<PerformanceBloc>(
            create: (context) => PerformanceBloc(),
            child: FutureBuilder<List<dynamic>>(
                future: listCpuUtil,
                builder: (context, snapshot) {
                  //adding connectionState i'm sure when i press the refresh button to show the circular progress bar
                  // because after set state the hasData and hasError aren't reset until the response is back
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    var data = snapshot.data;

                    //generate the event to rebuild the charts
                    context.read<PerformanceBloc>().add(ChartDownloadEvent(
                        data![0] as List<dynamic>,
                        data[1] as List<dynamic>,
                        data[2] as List<dynamic>,
                        data[3] as List<dynamic>,
                        data[4] as List<dynamic>,
                        data[5] as List<dynamic>));

                    return ListView(
                      children: const <Widget>[
                        const SizedBox(
                          height: 5,
                        ),
                        ResourceOneLineWidget("CPU"),
                        const SizedBox(
                          height: 5,
                        ),
                        ResourceOneLineWidget("RAM"),
                        const SizedBox(
                          height: 5,
                        ),
                        ResourceTwoLineWidget("DISK", "B/s", "Read", "Write"),
                        const SizedBox(
                          height: 5,
                        ),
                        ResourceTwoLineWidget(
                            "NETWORK", "bps", "Inbound", "Outbound"),
                      ],
                    );
                  }
                  ;

                  if (snapshot.hasError &&
                      snapshot.connectionState == ConnectionState.done) {
                    return Center(child: Text("No Data!"));
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                })));
  }
}
