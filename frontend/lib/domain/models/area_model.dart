import 'package:mapbox_gl/mapbox_gl.dart';

abstract class AreaModel {
  AreaModel({required this.geometry});

  final List<List<LatLng>> geometry;
}