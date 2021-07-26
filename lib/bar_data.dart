import 'package:flutter/material.dart';

class BarData<T> {
  /// graph value
  final double value;

  /// bottom text
  final String? label;

  /// index
  final int index;

  /// If you need Pointed BarData's data, use this.
  final T? data;

  BarData(
      {required this.value, this.label = '', required this.index, this.data});

  String toString() {
    return "index : $index, value : $value, label : $label";
  }
}

class ChartData {
  /// Selected Bar Color
  final Color selectedColor;

  /// Selected Bar Bottom Text Style
  final TextStyle? selectedTextStyle;

  /// Unselected Bar Color
  final Color unselectedColor;

  /// Unselected Bar Bottom Text Style
  final TextStyle? unselectedTextStyle;

  /// Called when user Scroll chart or Tap Bar
  final ValueChanged<BarData>? onChanged;

  /// Chart's Width
  final double chartWidth;

  /// Chart's Height
  /// It has 4 + itemBottomHeight + itemHeight
  final double chartHeight;

  /// Chart's Background Color
  final Color chartBackgroundColor;

  /// Chart's Border
  final Border chartBorder;

  /// Bar's strokeWidth
  final double strokeWidth;

  /// Bar Item's itemWidth
  final double itemWidth;

  /// Bar Item's itemHeight
  final double itemHeight;

  /// Bar Label's Height
  final double itemBottomHeight;

  /// Bar Label's Background Color
  final Color itemBottomBackgroundColor;

  /// Bar Item's Count
  final int itemCount;

  /// Chart's scrollController
  final ScrollController scrollController;

  /// Bar Data's maxValue
  final double maxValue;

  /// Bar Data's minValue Default 0
  final double minValue;

  ChartData(
      {required this.selectedColor,
      this.selectedTextStyle,
      required this.maxValue,
      this.minValue = 0,
      required this.chartBorder,
      required this.unselectedColor,
      this.unselectedTextStyle,
      this.onChanged,
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
