import 'package:frontend/domain/models/area_model.dart';
import 'package:frontend/domain/models/information_model.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class CulturalHeritageModel extends AreaModel implements InformationModel{
  CulturalHeritageModel(this.oid, List<List<LatLng>> geometry) : super(geometry);
  int oid;

  @override
  Map<String, String> dataToMap() {
    // TODO: implement dataToMap
    throw UnimplementedError();
  }
  CulturalHeritageModel.fromJson(Map<String, dynamic> json)
      : oid = json['oid'],
        super.fromJson(json['polygons']);

}