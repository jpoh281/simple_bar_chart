import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_bar_chart/bar_data.dart';
import 'package:simple_bar_chart/simple_bar_chart.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SampleChart(),
    );
  }
}

final nowBarDataProvider = StateProvider<BarData?>((ref) => null);

class SampleChart extends ConsumerStatefulWidget {
  @override
  _SampleChartState createState() => _SampleChartState();
}

class _SampleChartState extends ConsumerState<SampleChart> {
  ScrollController scrollController = ScrollController();
  Size? size;
  late List<BarData> datas;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    datas = List.generate(
        300,
        (index) => BarData(
            index: index,
            value: Random().nextInt(600) + 100,
            label: index.toString()));
  }



  @override
  Widget build(BuildContext context) {
    if (size == null) size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SimpleBarChart(
                chartData: ChartData(
                  strokeWidth: 12,
                  scrollController: scrollController,
                  chartBackgroundColor: Colors.transparent,
                  selectedColor: Colors.green,
                  unselectedColor: Colors.grey,
                  selectedTextStyle: TextStyle(color: Colors.green),
                  unselectedTextStyle: TextStyle(color: Colors.grey),
                  itemBottomHeight: 40.0,
                  itemWidth: 70.0,
                  itemHeight: 300.0,
                  itemCount: 300,
                  minValue: 100,
                  maxValue: 700,
                  chartWidth: size!.width - 10.0,
                  chartHeight: 344,
                  onChanged: (value) {
                    ref.read(nowBarDataProvider).state = value;
                  },
                  chartBorder: Border(
                    top: BorderSide(color: Colors.black, width: 2.0),
                    left: BorderSide(color: Colors.black, width: 2.0),
                    right: BorderSide(color: Colors.black, width: 2.0),
                    bottom: BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
                barDatas: datas),

            Consumer(builder: (context, ref, child) {
              BarData nowData = ref.watch(nowBarDataProvider).state ?? datas[0];
              return Text(nowData.toString());
            }),
          ],
        ),
      ),
    );
  }
}
