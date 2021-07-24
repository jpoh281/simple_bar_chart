library simple_bar_chart;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_bar_chart/bar.dart';
import 'package:simple_bar_chart/bar_data.dart';
import 'package:simple_bar_chart/bar_text.dart';

bool _scrollLock = false;
bool _isScrolling = false;


class SimpleBarChart extends StatefulWidget {
  final ChartData chartData;
  final List<BarData> barDatas;
  SimpleBarChart({required this.chartData, required this.barDatas});

  @override
  _SimpleBarChartState createState() => _SimpleBarChartState();
}

class _SimpleBarChartState extends State<SimpleBarChart> {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
        overrides: [
          chartDataProvider.overrideWithValue(widget.chartData),
          barDataListProvider.overrideWithValue(widget.barDatas)
        ],
        child: Center(
          child: Container(
            decoration: BoxDecoration(border: widget.chartData.chartBorder),
            width: widget.chartData.chartWidth,
            height: widget.chartData.chartHeight,
            child: Stack(children: [
              Container(
                color: widget.chartData.chartBackgroundColor,
              ),
              const SimpleBarChartWidget(),
            ]),
          ),
        ));
  }
}

final pointIndexProvider = StateProvider<int>((ref) {
  return 0;
});

final chartDataProvider =
    Provider<ChartData>((ref) => throw UnimplementedError());
final barDataListProvider =
    Provider<List<BarData>>((ref) => throw UnimplementedError());
final barDataProvider = Provider<BarData>((ref) => throw UnimplementedError());


class SimpleBarChartWidget extends ConsumerStatefulWidget {
  const SimpleBarChartWidget({Key? key}) : super(key : key);

  @override
  SimpleBarChartWidgetState createState() => SimpleBarChartWidgetState();
}

class SimpleBarChartWidgetState extends ConsumerState<SimpleBarChartWidget> {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is ScrollStartNotification) {
          _isScrolling = true;
        } else if (scrollNotification is ScrollUpdateNotification) {
          int nearestBarIndex =
              nearestBar(scrollNotification.metrics.extentBefore);
          if (ref.read(pointIndexProvider).state != nearestBarIndex &&
              nearestBarIndex < ref.watch(chartDataProvider).itemCount) {
            ref.read(pointIndexProvider).state = nearestBarIndex;
            ref.read(chartDataProvider).onChanged!.call(ref.read(barDataListProvider)[nearestBarIndex]);
          }
        } else if (scrollNotification is ScrollEndNotification) {
          if (!_scrollLock) {
            _scrollLock = true;
            int nearestBarIndex =
                nearestBar(scrollNotification.metrics.extentBefore);
            if (nearestBarIndex < ref.watch(chartDataProvider).itemCount) {
              ref.read(pointIndexProvider).state = nearestBarIndex;
              ref.watch(chartDataProvider).scrollController.jumpTo(
                  nearestBarIndex * ref.watch(chartDataProvider).itemWidth);
              ref.read(chartDataProvider).onChanged!.call(ref.read(barDataListProvider)[nearestBarIndex]);
              _scrollLock = false;
            }
          }
          _isScrolling = false;
        }
        return false;
      },
      child: SingleChildScrollView(
        dragStartBehavior: DragStartBehavior.down,
        controller: ref.watch(chartDataProvider).scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
                width: ref.watch(chartDataProvider).chartWidth / 2 -
                    ref.watch(chartDataProvider).itemWidth / 2),
            ListView.builder(
              primary: false,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ProviderScope(overrides: [
                  barDataProvider
                      .overrideWithValue(ref.watch(barDataListProvider)[index])
                ], child: const BarItem());
              },
              itemCount: ref.watch(chartDataProvider).itemCount,
            ),
            Container(
                width: ref.watch(chartDataProvider).chartWidth / 2 -
                    ref.watch(chartDataProvider).itemWidth / 2),
          ],
        ),
      ),
    );
  }

  int nearestBar(double now) {
    double index = now / ref.watch(chartDataProvider).itemWidth;
    int left = index.round();
    return left;
  }
}

class BarItem extends ConsumerWidget {
  const BarItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ChartData chartData = ref.watch(chartDataProvider);
    BarData barData = ref.watch(barDataProvider);

    return GestureDetector(
      onTapUp: (_) {
        if (!_isScrolling) {
          chartData.scrollController
              .animateTo(barData.index * chartData.itemWidth, duration: Duration(milliseconds: 300),curve : Curves.fastOutSlowIn);
          ref.read(pointIndexProvider).state = barData.index;
          ref.read(chartDataProvider).onChanged!.call(barData);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [const Bar(), const BarText()],
      ),
    );
  }
}
