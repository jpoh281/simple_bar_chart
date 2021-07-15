library simple_bar_chart;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

int selectedIndex = 0;
bool isScrollLock = false;
bool isScrolling = false;
late double barHeight;
late double barWidth;
late ScrollController scrollController;
double? chartHeight;
late double chartWidth;

class SimpleBarChart extends StatefulWidget {
  /// If you want to move when you TapUp,
  /// Wrap Widget & input onTapUp method
  /// (TapUpDetails details){
  ///   if(scrolling){
  ///     scrollController.jumpTo(index * 80.0);
  ///     nowIndex = index;
  ///   }
  /// }
  final List<Widget> items;

  SimpleBarChart.custom(
      {required scrollController,
      required chartWidth,
      required barWidth,
      required barHeight,
      required this.items,
      chartHeight}) {
    barHeight = barHeight;
    barWidth = barWidth;
    chartWidth = chartWidth;
    scrollController = scrollController;
    chartHeight = chartHeight;
  }

  SimpleBarChart(
      {required scrollController,
        required chartWidth,
        required barWidth,
        required barHeight,
        required this.items,
        chartHeight}) {
    barHeight = barHeight;
    barWidth = barWidth;
    chartWidth = chartWidth;
    scrollController = scrollController;
    chartHeight = chartHeight;
  }

  @override
  _SimpleBarChartState createState() => _SimpleBarChartState();
}

class _SimpleBarChartState extends State<SimpleBarChart> {
  int nearestBar(double now) {
    double index = now / 80;

    int left = index.round();
    return left;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is ScrollStartNotification) {
          isScrolling = true;
        } else if (scrollNotification is ScrollUpdateNotification) {
          int nearestBarIndex =
              nearestBar(scrollNotification.metrics.extentBefore);
          selectedIndex = nearestBarIndex;
        } else if (scrollNotification is ScrollEndNotification) {
          if (!isScrollLock) {
            isScrollLock = true;
            int nearestBarIndex =
                nearestBar(scrollNotification.metrics.extentBefore);

            selectedIndex = nearestBarIndex;
            scrollController.jumpTo(nearestBarIndex * barWidth);
            isScrollLock = false;
          }
          isScrolling = false;
        }
        return false;
      },
      child: SingleChildScrollView(
        dragStartBehavior: DragStartBehavior.down,
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(width: chartWidth / 2 - barWidth / 2),
            ...widget.items,
            Container(width: chartWidth / 2 - barWidth / 2),
          ],
        ),
      ),
    );
  }
}
