import 'package:frontend/domain/models/dot_model.dart';
import 'package:frontend/domain/models/information_model.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class OrganizationModel extends DotModel implements InformationModel {
  OrganizationModel(this.oid,LatLng location): super(location);
  int oid;

  @override
  Map<String, String> dataToMap() {
    // TODO: implement dataToMap
    throw UnimplementedError();
  }
  OrganizationModel.fromJson(Map<String, dynamic> json)
      : oid = json['oid'],
        super.fromJson(json['point']);

}