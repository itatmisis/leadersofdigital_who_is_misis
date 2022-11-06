import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/data/api/api.dart';
import 'package:frontend/data/storage/storage.dart';
import 'package:frontend/presentation/screens/main_screen/bloc/polygon_loader_cubit.dart';
import 'package:frontend/presentation/screens/main_screen/map/map_modes/draw_cubit.dart';
import 'package:frontend/presentation/screens/main_screen/map/map_modes/lands_impl.dart';
import 'package:frontend/presentation/screens/main_screen/map/map_modes/layers_state.dart';
import 'package:frontend/presentation/screens/main_screen/map/map_modes/map_cubit.dart';
import 'package:frontend/presentation/theme/app_colors.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import 'map_interface.dart';

class HeatMapImpl implements MapInterface {
  @override
  void dispose(BuildContext context) {
    // TODO: implement dispose
  }

  @override
  void init(BuildContext context) async {
    context.read<DrawCubit>().layers.add(DotLayerModel(geometry: LatLng(55.84762, 37.5658), fillColor: AppColors.veryPeri900, outlineColor: AppColors.veryPeri900, opacity: 1, size: 100));
    context.read<DrawCubit>().draw();
  }

  @override
  void onCameraMove(BuildContext context, CameraPosition cameraPosition) {
    print(cameraPosition.zoom);
    if (cameraPosition.zoom > 13) {
      dispose(context);
      context.read<MapCubit>().push(LandsImpl());
    }
  }

  @override
  void onMapPressed(BuildContext context, {PointAndLatLng? point, Annotation? annotation}) {

  }

}