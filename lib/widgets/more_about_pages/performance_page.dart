import 'package:app_sangfor/api/api_call/performance_apicall.dart';
import 'package:app_sangfor/blocs/performance_bloc/bloc.dart';
import 'package:app_sangfor/cache/Vm_Cache.dart';
import 'package:app_sangfor/widgets/widget_performance/cpu_widget.dart';
import 'package:fl_chart/fl_chart.dart';
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
  final performanceVM = PerformanceVM_ApiCall();
  late Future<List<List<dynamic>>> listCpuUtil;

  @override
  void initState() {
    super.initState();
    listCpuUtil = performanceVM.getCpuUtilisation(
        context, Provider.of<VmCache>(context, listen: false).urlServer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Performance")),
        body: FutureBuilder<List<List<dynamic>>>(
            future: listCpuUtil,
            builder: (context, snapshot) {
              //adding connectionState i'm sure when i press the refresh button to show the circular progress bar
              // because after set state the hasData and hasError aren't reset until the response is back
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                var data = snapshot.data;

                return BlocProvider(
                    create: (context) => PerformanceBloc(),
                    child: Column(
                      children: const <Widget>[
                        CpuWidget(),
                      ],
                    ));
              }
              ;

              if (snapshot.hasError &&
                  snapshot.connectionState == ConnectionState.done) {
                return Center(child: Text("No Data!"));
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
