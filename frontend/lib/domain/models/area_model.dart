import 'package:frontend/domain/models/geographic_model.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

abstract class AreaModel extends GeographicModel {
  AreaModel({required this.geometry});

  final List<List<LatLng>> geometry;
}