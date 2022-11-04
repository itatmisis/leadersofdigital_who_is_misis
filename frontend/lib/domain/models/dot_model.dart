import 'package:mapbox_gl/mapbox_gl.dart';

abstract class DotModel {
  DotModel({required this.location});

  final LatLng location;
}