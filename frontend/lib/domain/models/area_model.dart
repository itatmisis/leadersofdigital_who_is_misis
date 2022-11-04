import 'package:mapbox_gl/mapbox_gl.dart';

class AreaModel {
  AreaModel({required this.geometry, required this.cadnum});

  final List<LatLng> geometry;
  final String cadnum;
}