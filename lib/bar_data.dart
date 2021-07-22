import 'package:flutter/material.dart';

class BarData {
  final double value;
  final String? label;
  final int index;

  BarData({required this.value, this.label = '', required this.index});
}

class ChartData {
  final Color selectedColor;
  final TextStyle selectedTextStyle;

  final Color unselectedColor;
  final TextStyle unselectedTextStyle;

  final double chartWidth;
  final double chartHeight;
  final Color chartBackgroundColor;
  final Border chartBorder;

  final double strokeWidth;
  final List<double> baseLines;
  final double itemWidth;
  final double itemHeight;
  final double itemBottomHeight;
  final Color itemBottomBackgroundColor;

  final int itemCount;
  final ScrollController scrollController;

  ChartData(
      {required this.selectedColor,
      required this.selectedTextStyle,
      required this.chartBorder,
      required this.unselectedColor,
      required this.unselectedTextStyle,
      this.baseLines = const [],
      required this.strokeWidth,
      required this.chartWidth,
      required this.chartHeight,
      required this.itemWidth,
      required this.itemBottomHeight,
      required this.chartBackgroundColor,
      required this.itemHeight,
      this.itemBottomBackgroundColor = Colors.transparent,
      required this.itemCount,
      required this.scrollController});
}
