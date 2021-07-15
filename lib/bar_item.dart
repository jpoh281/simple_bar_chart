import 'package:flutter/material.dart';
import 'package:simple_bar_chart/bar.dart';
import 'package:simple_bar_chart/bar_text.dart';
import 'package:simple_bar_chart/simple_bar_chart.dart';

class BarItem extends StatelessWidget {
  final double value;
  final int index;
  final Color selectedColor;
  final Color unselectedColor;
  final Color selectedTextStyle;
  final Color unselectedTextStyle;

  const BarItem(
      {Key? key,
      required this.value,
      required this.index,
      required this.selectedColor,
      required this.unselectedColor,
      required this.selectedTextStyle, required this.unselectedTextStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (_) {
        if (!isScrolling) {
          scrollController.jumpTo(index * barWidth);
          selectedIndex = index;
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Bar(
            value: value,
            index: index,
            selectedColor: selectedColor,
            unselectedColor: unselectedColor,
          ),
          BarText(
            index: index,
          )
        ],
      ),
    );
  }
}
