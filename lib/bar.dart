import 'package:flutter/material.dart';
import 'package:simple_bar_chart/simple_bar_chart.dart';

class Bar extends StatelessWidget {
  const Bar(
      {required this.value,
      required this.index,
      required this.selectedColor,
      required this.unselectedColor});

  final double value;
  final int index;
  final Color selectedColor;
  final Color unselectedColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: barWidth,
      height: barHeight,
      child: CustomPaint(
        painter: BarPainter(value, index, selectedColor, unselectedColor),
      ),
    );
  }
}

class BarPainter extends CustomPainter {
  const BarPainter(
      this.value, this.index, this.selectedColor, this.unselectedColor);

  final int index;
  final double value;
  final Color selectedColor;
  final Color unselectedColor;

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 12.0;
    final center = Offset(size.width / 2, size.height - 20);
    final end = Offset(size.width / 2, size.height - 20 - value);

    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = (index == selectedIndex) ? selectedColor : unselectedColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(center, end, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
