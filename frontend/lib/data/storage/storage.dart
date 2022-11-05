import 'package:frontend/domain/models/building_model.dart';
import 'package:frontend/domain/models/capital_model.dart';
import 'package:frontend/domain/models/land_model.dart';
import 'package:frontend/domain/models/organization_model.dart';
import 'package:frontend/domain/models/sanitary_model.dart';
import 'package:frontend/domain/models/start_model.dart';

class Storage {

  static final Storage _instance = Storage._();

  factory Storage() => _instance;
  Storage._();

  Map<int, LandModel> lands = {};
  Map<int, CapitalModel> capitals = {};
  Map<int, OrganizationModel> organizations = {};
  Map<int, SanitaryModel> sanitaries = {};
  Map<int, StartModel> starts = {};
  Map<int, BuildingModel> buildings = {};
}