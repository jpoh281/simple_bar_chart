import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_bar_chart/bar_data.dart';
import 'package:simple_bar_chart/simple_bar_chart.dart';

class Bar extends ConsumerWidget {
  const Bar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ChartData chartData = ref.watch(chartDataProvider);
    BarData barData = ref.watch(barDataProvider);

    bool isPointed = ref.watch(pointIndexProvider.select((value) {
      return value.state == barData.index;
    }));

    return SizedBox(
      width: chartData.itemWidth,
      height: chartData.itemHeight,
      child: CustomPaint(
        painter: BarPainter(barData: barData, chartData: chartData, isPointed: isPointed),
      ),
    );
  }
}

class BarPainter extends CustomPainter {
  final BarData barData;
  final ChartData chartData;
  final bool isPointed;
  const BarPainter({required this.barData,required this.chartData,required this.isPointed});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height - 20);
    final end = Offset(size.width / 2, size.height - 20 - barData.value);

    final paint = Paint()
      ..strokeWidth = chartData.strokeWidth
      ..color = isPointed ? chartData.selectedColor : chartData.unselectedColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(center, end, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
