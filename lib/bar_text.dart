import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_bar_chart/bar_data.dart';
import 'package:simple_bar_chart/simple_bar_chart.dart';

class BarText extends ConsumerWidget {
  const BarText();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ChartData chartData = ref.watch(chartDataProvider);
    BarData barData = ref.watch(barDataProvider);
    bool isPointed = ref.watch(pointIndexProvider.select((value) {
      return value.state == barData.index;
    }));

    return Container(
      color: chartData.itemBottomBackgroundColor,
      height: chartData.itemBottomHeight,
      width: chartData.itemWidth,
      child: Center(
        child: Text(
          barData.label ?? '', textAlign: TextAlign.center, style: isPointed ? chartData.selectedTextStyle : chartData.unselectedTextStyle,
        ),
      )
    );
  }
}

