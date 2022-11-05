import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:frontend/data/api/api_routes/api_routes.dart';
import 'package:frontend/data/interceptors/error_interceptor.dart';
import 'package:frontend/domain/models/cultural_heritage_model.dart';
import 'package:frontend/domain/models/land_model.dart';
import 'package:frontend/domain/models/organization_model.dart';
import 'package:frontend/domain/models/sanitary_model.dart';
import 'package:frontend/domain/models/start_model.dart';

import '../../domain/models/capital_model.dart';

class Api {
  late Dio _client;

  static final Api _instance = Api._newInstance();

  factory Api() => _instance;

  Api._newInstance() {
    final dio = Dio(BaseOptions(
      baseUrl: 'http://89.108.102.188:5000/api',
      connectTimeout: 1000000,
    ));
    dio.interceptors.add(ErrorInterceptor());
    _client = dio;
  }

  Future<Map<int, LandModel>> getLands() async {
    List<LandModel> res = [];
    final response = await _client.get(ApiRoutes.getLands);

    Map<int, LandModel> m = {};

    for (var j in response.data['lands']) {
      m[j['oid']] = LandModel.fromJson(j);
    }

    return m;
  }

  Future<Map<int, CapitalModel>> getCapital() async {
    final response = await _client.get(ApiRoutes.getCapital);

    Map<int, CapitalModel> m = {};

    for (var j in response.data['capital_construction_works']) {
      m[j['oid']] = CapitalModel.fromJson(j);
    }

    return m;
  }

  Future<Map<int, SanitaryModel>> getSanitary() async {
    final response = await _client.get(ApiRoutes.getSanitary);

    Map<int, SanitaryModel> m = {};

    for (var j in response.data['sanitary_protected_zones']) {
      m[j['oid']] = SanitaryModel.fromJson(j);
    }

    return m;
  }

  Future<Map<int, StartModel>> getStartGrounds() async {
    final response = await _client.get(ApiRoutes.getStartGrounds);

    Map<int, StartModel> m = {};

    for (var j in response.data['start_grounds']) {
      m[j['oid']] = StartModel.fromJson(j);
    }

    return m;
  }

  Future<Map<int, CulturalHeritageModel>> getCulturalHeritage() async {
    final response = await _client.get(ApiRoutes.getCulturalHeritage);

    Map<int, CulturalHeritageModel> m = {};

    for (var j in response.data['cultural_heritage']) {
      m[j['oid']] = CulturalHeritageModel.fromJson(j);
    }

    return m;
  }

  Future<Map<int, OrganizationModel>> getOrganizations() async {
    final response = await _client.get(ApiRoutes.getOrganizations);
    Map<int, OrganizationModel> m = {};
    for (var j in response.data['organizations']) {
      m[j['oid']] = OrganizationModel.fromJson(j);
    }
    log("SUCCESS ORGANIZATIONS");
    return m;
  }
}
