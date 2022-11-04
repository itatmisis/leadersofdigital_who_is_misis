import 'package:frontend/domain/models/area_model.dart';

class Storage {

  static final Storage _instance = Storage._();

  factory Storage() => _instance;
  Storage._();

  Map<int, AreaModel> _polygons = {};

  Map<int, AreaModel> get polygons => _polygons;
  set polygons(Map<int, AreaModel>  p) => _polygons = p;

}