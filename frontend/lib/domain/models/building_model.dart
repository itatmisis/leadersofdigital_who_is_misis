import 'package:frontend/domain/models/dot_model.dart';
import 'package:frontend/domain/models/information_model.dart';

class BuildingModel extends DotModel implements InformationModel {
  BuildingModel({required super.location});

  @override
  Map<String, String> dataToMap() {
    // TODO: implement dataToMap
    throw UnimplementedError();
  }

}