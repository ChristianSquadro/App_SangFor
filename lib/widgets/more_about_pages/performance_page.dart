import 'package:flutter/material.dart';

class PerformancePage extends StatefulWidget
{
  const PerformancePage();

  @override
  _PerformanceState createState() => _PerformanceState();

}

class _PerformanceState extends State<PerformancePage>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Performance")),
    );
  }
}