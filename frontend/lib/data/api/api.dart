import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:frontend/data/api/api_routes/api_routes.dart';
import 'package:frontend/data/interceptors/error_interceptor.dart';
import 'package:frontend/domain/models/cultural_heritage_model.dart';
import 'package:frontend/domain/models/land_model.dart';
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

  Future<LandModel> getLands() async {
    List<LandModel> res=[];
    final response = await _client.get(ApiRoutes.getLands);
    final json = jsonDecode(response.data);
    return LandModel.fromJson(json);
  }
  Future<CapitalModel> getCapital() async {
    final response = await _client.get(ApiRoutes.getCapital);
    final json = jsonDecode(response.data);
    return CapitalModel.fromJson(json);
  }
  Future<SanitaryModel> getSanitary() async {
    final response = await _client.get(ApiRoutes.getSanitary);
    final json = jsonDecode(response.data);
    return SanitaryModel.fromJson(json);
  }
  Future<StartModel> getStartGrounds() async {
    final response = await _client.get(ApiRoutes.getStartGrounds);
    final json = jsonDecode(response.data);
    return StartModel.fromJson(json);
  }
  Future<CulturalHeritageModel> getCulturalHeritage() async {
    final response = await _client.get(ApiRoutes.getCulturalHeritage);
    final json = jsonDecode(response.data);
    return CulturalHeritageModel.fromJson(json);
  }


}
