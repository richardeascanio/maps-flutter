part of 'helpers.dart';

Future<BitmapDescriptor> getInitialMarkerIcon(int seconds) async {
  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder);
  final size = ui.Size(350, 150);

  final minutes = (seconds/60).floor();
  final initialMarker = InitialMarkerPainter(minutes);
  initialMarker.paint(canvas, size);

  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData.buffer.asUint8List());
}

Future<BitmapDescriptor> getDestinationMarkerIcon(double meters, String placeName) async {
  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder);
  final size = ui.Size(350, 150);

  final destinationMarker = DestinationMarkerPainter(meters, placeName);
  destinationMarker.paint(canvas, size);

  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData.buffer.asUint8List());
}