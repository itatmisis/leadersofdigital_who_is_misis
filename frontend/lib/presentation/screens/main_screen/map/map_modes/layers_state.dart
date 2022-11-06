import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/domain/models/area_model.dart';
import 'package:frontend/presentation/screens/main_screen/map/map_modes/layers_state.dart';
import 'package:mapbox_gl/mapbox_gl.dart';


abstract class LayerModel {}
class LayerState {
  final List<LayerModel> layers;

  const LayerState(this.layers);
}

class FillLayerModel extends LayerModel{
  FillLayerModel({required this.event, required this.fillColor, required this.outlineColor, required this.onClick, required this.opacity});

  Map<int, AreaModel> event;
  Color fillColor, outlineColor;
  Function(AreaModel, Fill) onClick;
  double? opacity;
}

class UpdateFillLayerModel extends LayerModel{
  UpdateFillLayerModel({required this.fill, required this.fillColor, required this.outlineColor, required this.opacity});

  Fill fill;
  Color fillColor, outlineColor;
  double? opacity;
}

class DotLayerModel extends LayerModel{
  DotLayerModel({required this.geometry, this.size, required this.fillColor, required this.outlineColor, required this.opacity});

  LatLng geometry;
  Color fillColor, outlineColor;
  double? opacity;
  double? size;
}

class PolyLayerModel extends LayerModel{
  PolyLayerModel({required this.geometry, required this.fillColor, required this.outlineColor, required this.opacity});

  List<LatLng> geometry;
  Color fillColor, outlineColor;
  double? opacity;
}