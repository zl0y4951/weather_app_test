import 'package:flutter/material.dart';
import 'package:weather_app_test/core/constants/colors.dart';
import 'package:weather_app_test/core/extensions/canvas_dashed.dart';
import 'package:weather_app_test/core/extensions/time_format.dart';

class SunCard extends StatelessWidget {
  const SunCard({super.key, required this.sunrise, required this.sunset});
  final DateTime sunrise, sunset;

  String get differenceTime {
    final dur = sunset.difference(sunrise);
    return "${dur.inHours}ч ${dur.inMinutes % 60}м";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 11),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(11)),
          color: CustomColors.light,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Закат и рассвет',
                style: TextStyle(color: CustomColors.lightgrey, fontSize: 12),
              ),
              CustomPaint(
                size: const Size(double.infinity, 129),
                painter: SunChartPainter(DateTime.now(), sunrise, sunset),
              ),
              Text.rich(
                TextSpan(text: 'Длина дня: ', children: [
                  TextSpan(
                    text: differenceTime,
                    style: const TextStyle(
                      color: CustomColors.dark,
                    ),
                  )
                ]),
                style: const TextStyle(
                    color: CustomColors.lightgrey, fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SunChartPainter extends CustomPainter {
  final DateTime currentTime;
  final DateTime sunrise;
  final DateTime sunset;

  const SunChartPainter(this.currentTime, this.sunrise, this.sunset);

  @override
  void paint(Canvas canvas, Size size) {
    final centerHeight = size.height / 2;

    final Paint horizonPaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1.0;

    final Paint dayPaint = Paint()
      ..color = Colors.blue[300]!
      ..style = PaintingStyle.fill;
    final Paint nightPaint = Paint()
      ..color = Colors.indigo[900]!
      ..style = PaintingStyle.fill;

    // Рисуем линию горизонта
    canvas.drawDashedLine(
      Offset(0, centerHeight),
      Offset(size.width, centerHeight),
      horizonPaint,
    );
    final double sunriseX =
        (sunrise.hour * 60 + sunrise.minute) / (24 * 60) * size.width;
    final double sunsetX =
        (sunset.hour * 60 + sunset.minute) / (24 * 60) * size.width;

    _drawText(
        canvas, Offset(sunriseX, centerHeight - 45), 'Рассвет', size.width);
    _drawText(
      canvas,
      Offset(sunriseX, centerHeight - 30),
      sunrise.hhmm,
      size.width,
      const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: CustomColors.darkgrey),
    );
    _drawText(canvas, Offset(sunsetX, centerHeight - 45), 'Закат', size.width);
    _drawText(
      canvas,
      Offset(sunsetX, centerHeight - 30),
      sunset.hhmm,
      size.width,
      const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: CustomColors.darkgrey),
    );

    canvas.drawDashedLine(Offset(sunriseX, centerHeight - 20),
        Offset(sunriseX, centerHeight), horizonPaint);

    canvas.drawDashedLine(Offset(sunsetX, centerHeight - 20),
        Offset(sunsetX, centerHeight), horizonPaint);

    final Path nightPath = Path()
      ..moveTo(0, centerHeight)
      ..quadraticBezierTo(sunriseX / 2,
          size.height / (2 - (sunriseX / size.width)), sunriseX, centerHeight)
      ..moveTo(sunsetX, centerHeight)
      ..quadraticBezierTo((sunsetX + size.width) / 2,
          size.height / (2 - (sunriseX / size.width)), size.width, centerHeight)
      ..close();

    canvas.drawPath(nightPath, nightPaint);

    final Path dayPath = Path()
      ..moveTo(sunriseX, centerHeight)
      ..quadraticBezierTo(
        (sunsetX + sunriseX) / 2,
        0 + centerHeight / (2 - (sunriseX / size.width)),
        sunsetX,
        centerHeight,
      )
      ..close();

    canvas.drawPath(dayPath, dayPaint);
  }

  void _drawText(Canvas canvas, Offset offset, String text, double maxWidth,
      [TextStyle textStyle = const TextStyle(
        color: CustomColors.lightgrey,
        fontSize: 10,
      )]) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: maxWidth);
    textPainter.paint(
        canvas,
        Offset(offset.dx - (textPainter.width / 2),
            offset.dy - (textPainter.height / 2)));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
