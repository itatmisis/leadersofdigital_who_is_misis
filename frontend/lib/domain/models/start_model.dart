import 'package:frontend/domain/models/area_model.dart';
import 'package:frontend/domain/models/information_model.dart';

class StartModel extends AreaModel implements InformationModel{
  StartModel({required super.geometry});

  @override
  Map<String, String> dataToMap() {
    // TODO: implement dataToMap
    throw UnimplementedError();
  }

}