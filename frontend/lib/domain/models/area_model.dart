import 'package:frontend/domain/models/geographic_model.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

abstract class AreaModel extends GeographicModel {
  AreaModel(this.geometry);

  late List<List<LatLng>> geometry;

  AreaModel.fromJson(List<List<Map<String, double>>> json) {
    for (int i = 0; i < json.length; i++) {
      List<LatLng> polygons = [];
      for (int j = 0; j < json[i].length; j++) {
        polygons.add(LatLng(json[i][j]["lat"]!, json[i][j]["lon"]!));
      }
      geometry.add(polygons);
    }
  }
}
