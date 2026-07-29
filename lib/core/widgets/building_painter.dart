import 'package:co_works/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// A custom painter that draws a stylised logo of dual skyscraper towers.
class BuildingPainter extends CustomPainter {
  final Color windowColor;

  BuildingPainter({Color? windowColor})
    : windowColor = windowColor ?? AppColors.primary;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Draw left tower (shorter)
    // Left tower is from x = 12% to 50% of width
    // y is from 42% to 90% of height
    final leftTower = Rect.fromLTRB(
      size.width * 0.12,
      size.height * 0.42,
      size.width * 0.50,
      size.height * 0.90,
    );
    canvas.drawRect(leftTower, paint);

    // Draw right tower (taller)
    // Right tower is from x = 50% to 88% of width
    // y is from 15% to 90% of height
    final rightTower = Rect.fromLTRB(
      size.width * 0.50,
      size.height * 0.15,
      size.width * 0.88,
      size.height * 0.90,
    );
    canvas.drawRect(rightTower, paint);

    // Draw windows
    // Windows are themed color
    final windowPaint = Paint()
      ..color = windowColor
      ..style = PaintingStyle.fill;

    final wWidth = size.width * 0.08;
    final wHeight = size.height * 0.08;

    // Left tower windows (2 rows, 2 columns)
    // Row 1: y = 0.52
    // Row 2: y = 0.72
    // Col 1: x = 0.20
    // Col 2: x = 0.36
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.20, size.height * 0.52, wWidth, wHeight),
      windowPaint,
    );
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.36, size.height * 0.52, wWidth, wHeight),
      windowPaint,
    );
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.20, size.height * 0.72, wWidth, wHeight),
      windowPaint,
    );
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.36, size.height * 0.72, wWidth, wHeight),
      windowPaint,
    );

    // Right tower windows (3 rows, 2 columns)
    // Row 1: y = 0.25
    // Row 2: y = 0.46
    // Row 3: y = 0.67
    // Col 1: x = 0.58
    // Col 2: x = 0.74
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.58, size.height * 0.25, wWidth, wHeight),
      windowPaint,
    );
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.74, size.height * 0.25, wWidth, wHeight),
      windowPaint,
    );
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.58, size.height * 0.46, wWidth, wHeight),
      windowPaint,
    );
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.74, size.height * 0.46, wWidth, wHeight),
      windowPaint,
    );
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.58, size.height * 0.67, wWidth, wHeight),
      windowPaint,
    );
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.74, size.height * 0.67, wWidth, wHeight),
      windowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
