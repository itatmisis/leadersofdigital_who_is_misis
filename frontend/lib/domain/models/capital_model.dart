import 'package:frontend/domain/models/area_model.dart';
import 'package:frontend/domain/models/information_model.dart';

class CapitalModel extends AreaModel implements InformationModel {
  CapitalModel({required super.geometry});

  @override
  Map<String, String> dataToMap() {
    // TODO: implement dataToMap
    throw UnimplementedError();
  }

}