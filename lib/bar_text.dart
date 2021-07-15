import 'package:flutter/material.dart';
import 'package:simple_bar_chart/simple_bar_chart.dart';

class BarText extends StatelessWidget {
  final int index;
  final String? text;
  final TextStyle? selectedTextStyle;
  final TextStyle? unselectedTextStyle;

  BarText(
      {required this.index,
      this.text,
      this.selectedTextStyle,
      this.unselectedTextStyle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: barWidth,
      child: CustomPaint(
        painter: BarBottomTextPainter(index, text ?? index.toString(),
            selectedTextStyle, unselectedTextStyle),
      ),
    );
  }
}

class BarBottomTextPainter extends CustomPainter {
  const BarBottomTextPainter(
      this.index, this.text, this.selectedTextStyle, this.unselectedTextStyle);

  final int index;
  final String text;
  final TextStyle? selectedTextStyle;
  final TextStyle? unselectedTextStyle;

  @override
  void paint(Canvas canvas, Size size) {
    final textCenter = Offset(size.width / 2 - 4, size.height / 2 - 6);

    final textSpan = TextSpan(
      text: text,
      style: index == selectedIndex ? selectedTextStyle : unselectedTextStyle,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: barWidth,
    );

    textPainter.paint(canvas, textCenter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
