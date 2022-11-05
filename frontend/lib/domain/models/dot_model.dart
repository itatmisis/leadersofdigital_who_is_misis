import 'package:frontend/domain/models/geographic_model.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

abstract class DotModel extends GeographicModel {
  DotModel({required this.location});

  final LatLng location;
}