import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_bar_chart/bar_data.dart';
import 'package:simple_bar_chart/simple_bar_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: SampleChart(),
    );
  }
}


class SampleChart extends StatefulWidget {
  @override
  _SampleChartState createState() => _SampleChartState();
}

class _SampleChartState extends State<SampleChart> {

  ScrollController scrollController = ScrollController();
  Size? size;
  late List<BarData> datas;
  bool value = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    datas = List.generate(300, (index) =>
        BarData(index: index, value: Random().nextInt(500).toDouble(), label: "1"));
  }

  @override
  Widget build(BuildContext context) {
    if (size == null) size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Switch(
              value: value,
              onChanged: (month){
                print(value);
                setState(() {
                  this.value = month;
                });
                scrollController.jumpTo(70 * 300 + size!.width -10);
              },
            ),
            SimpleBarChart(chartData: ChartData(
              strokeWidth: 12,
                scrollController: scrollController,
                chartBackgroundColor: Colors.transparent,
                selectedColor: Colors.green,
                unselectedColor: Colors.grey,
                selectedTextStyle: TextStyle(color: Colors.green),
                unselectedTextStyle: TextStyle(color: Colors.grey),
                itemBottomHeight: 40.0,
                itemWidth: 70.0,
                itemHeight: 500.0,
                itemCount: 300,
                chartWidth: size!.width - 10.0,
                chartHeight: 544,
                chartBorder: Border(
                  top: BorderSide(color: Colors.black, width: 2.0),
                  left: BorderSide(color: Colors.black, width: 2.0),
                  right: BorderSide(color: Colors.black, width: 2.0),
                  bottom: BorderSide(color: Colors.black, width: 2.0),
                ) ,
            ), barDatas: datas),
            Text("${value ? "월별" : "주별"}"),
          ],
        ),
      ),
    );
  }
}
