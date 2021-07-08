part of 'custom_markers.dart';

class DestinationMarkerPainter extends CustomPainter {

  final double meters;
  final String placeName;

  DestinationMarkerPainter(this.meters, this.placeName);

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
    path.moveTo(0, 20);
    path.lineTo(size.width-10, 20);
    path.lineTo(size.width-10, 100);
    path.lineTo(0, 100);

    canvas.drawShadow(
      path, 
      Colors.black87, 
      10.0, 
      false
    );

    // Draw white box
    final whiteBox = Rect.fromLTWH(0, 20, size.width-10, 80);
    canvas.drawRect(
      whiteBox, 
      paint
    );

    // Draw black box
    paint.color = Colors.black;
    final blackBox = Rect.fromLTWH(0, 20, 70, 80);
    canvas.drawRect(
      blackBox, 
      paint
    );

    // Draw texts
    double km = this.meters / 1000;
    km = (km * 100).floorToDouble();
    km = km / 100;
    TextSpan textSpan = TextSpan(
      style: TextStyle(
        color: Colors.white,
        fontSize: 22, 
        fontWeight: FontWeight.w400
      ),
      text: '$km'
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
      Offset(0, 35)
    );

    // Minutes
    textSpan = TextSpan(
      style: TextStyle(
        color: Colors.white,
        fontSize: 20, 
        fontWeight: FontWeight.w400
      ),
      text: 'Km'
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
      Offset(0, 67)
    );

    // My location
    textSpan = TextSpan(
      style: TextStyle(
        color: Colors.black,
        fontSize: 22, 
        fontWeight: FontWeight.w400
      ),
      text: this.placeName
    );

    textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
      maxLines: 2,
      ellipsis: '...'
    )..layout(
      maxWidth: size.width - 100,
    );

    textPainter.paint(
      canvas, 
      Offset(90, 35)
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}