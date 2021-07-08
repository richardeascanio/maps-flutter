part of 'custom_markers.dart';

class InitialMarkerPainter extends CustomPainter {

  final int minutes;

  InitialMarkerPainter(this.minutes);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
    ..color = Colors.black;
    // paint.color = Colors.black;

    // Draw black circle
    final blackCircleRadius = 20.0;
    final whiteCircleRadius = 7.0;

    canvas.drawCircle(
      Offset(blackCircleRadius, size.height-blackCircleRadius),
      blackCircleRadius,
      paint
    );

    // Draw white circle
    paint.color = Colors.white;
    canvas.drawCircle(
      Offset(blackCircleRadius, size.height-blackCircleRadius),
      whiteCircleRadius,
      paint
    );

    // Shadow
    final path = Path();
    path.moveTo(40, 20);
    path.lineTo(size.width-10, 20);
    path.lineTo(size.width-10, 100);
    path.lineTo(40, 100);

    canvas.drawShadow(
      path, 
      Colors.black87, 
      10.0, 
      false
    );

    // Draw white box
    final whiteBox = Rect.fromLTWH(40, 20, size.width-55, 80);
    canvas.drawRect(
      whiteBox, 
      paint
    );

    // Draw black box
    paint.color = Colors.black;
    final blackBox = Rect.fromLTWH(40, 20, 70, 80);
    canvas.drawRect(
      blackBox, 
      paint
    );

    // Draw texts
    TextSpan textSpan = TextSpan(
      style: TextStyle(
        color: Colors.white,
        fontSize: 30, 
        fontWeight: FontWeight.w400
      ),
      text: '$minutes'
    );

    TextPainter textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(
      maxWidth: 70,
      minWidth: 70
    );

    textPainter.paint(
      canvas, 
      Offset(40, 35)
    );

    // Minutes
    textSpan = TextSpan(
      style: TextStyle(
        color: Colors.white,
        fontSize: 20, 
        fontWeight: FontWeight.w400
      ),
      text: 'min'
    );

    textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(
      maxWidth: 70,
      minWidth: 70
    );

    textPainter.paint(
      canvas, 
      Offset(40, 67)
    );

    // My location
    textSpan = TextSpan(
      style: TextStyle(
        color: Colors.black,
        fontSize: 22, 
        fontWeight: FontWeight.w400
      ),
      text: 'My location'
    );

    textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(
      maxWidth: size.width - 130,
    );

    textPainter.paint(
      canvas, 
      Offset(160, 50)
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}