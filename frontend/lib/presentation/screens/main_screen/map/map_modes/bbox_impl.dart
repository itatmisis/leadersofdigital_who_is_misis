import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/data/api/api.dart';
import 'package:frontend/data/storage/storage.dart';
import 'package:frontend/presentation/screens/main_screen/bloc/layers_cubit.dart';
import 'package:frontend/presentation/screens/main_screen/bloc/polygon_loader_cubit.dart';
import 'package:frontend/presentation/screens/main_screen/map/map_modes/layers_state.dart';
import 'package:frontend/presentation/screens/main_screen/map/map_modes/map_interface.dart';
import 'package:frontend/presentation/theme/app_colors.dart';
import 'package:mapbox_gl_platform_interface/mapbox_gl_platform_interface.dart';

import 'draw_cubit.dart';

class BBoxImpl extends MapInterface {
  LatLng p1, p2;

  BBoxImpl(this.p1, this.p2);
  @override
  void dispose(BuildContext context) {
    // TODO: implement dispose
  }

  @override
  void init(BuildContext context) async {
    print('initBBoxLayer');

    context.read<DrawCubit>().layers = [];
    context.read<DrawCubit>().layers.add(FillLayerModel(event: Storage().lands, fillColor: AppColors.dewberry400, onClick:  (_, fill) {
      onMapPressed(context, annotation: fill);
    }, outlineColor: AppColors.dewberry900, opacity: 0.3));
    context.read<DrawCubit>().draw();


    context.read<LayersCubit>().stream.listen((event) async {

      context.read<DrawCubit>().layers = [];

      context.read<PolygonLoaderCubit>().load(DownloadedState.inProgress);
      if (event[0]) {
        if (Storage().lands.isEmpty) Storage().lands = await Api().getLands(lb: p1, rt: p2);

        context.read<DrawCubit>().layers.add(FillLayerModel(event: Storage().lands, fillColor: AppColors.dewberry400, onClick:  (_, fill) {
          onMapPressed(context, annotation: fill);
        }, outlineColor: AppColors.dewberry900, opacity: 0.3));
      }
      if (event[1]) {
        if (Storage().capitals.isEmpty) Storage().capitals = await Api().getCapital();

        context.read<DrawCubit>().layers.add(FillLayerModel(event: Storage().capitals, fillColor: AppColors.eggshellBlue400, onClick:  (_, fill) {
          onMapPressed(context, annotation: fill);
        }, outlineColor: AppColors.dewberry900, opacity: 0.3));
      }
      if (event[3]) {
        if (Storage().sanitaries.isEmpty) Storage().sanitaries = await Api().getSanitary();

        context.read<DrawCubit>().layers.add(FillLayerModel(event: Storage().sanitaries, fillColor: AppColors.lightGray, onClick:  (_, fill) {
          onMapPressed(context, annotation: fill);
        }, outlineColor: AppColors.dewberry900, opacity: 0.3));
      }
      if (event[4]) {
        if (Storage().starts.isEmpty) Storage().starts = await Api().getStartGrounds();

        context.read<DrawCubit>().layers.add(FillLayerModel(event: Storage().starts, fillColor: AppColors.gray, onClick:  (_, fill) {
          onMapPressed(context, annotation: fill);
        }, outlineColor: AppColors.dewberry900, opacity: 0.3));
      }

      context.read<PolygonLoaderCubit>().load(DownloadedState.downloaded);

      context.read<DrawCubit>().draw();
    });
  }

  @override
  void onCameraMove(BuildContext context, CameraPosition cameraPosition) {
    // TODO: implement onCameraMove
  }

  @override
  void onMapPressed(BuildContext context, {PointAndLatLng? point, Annotation? annotation}) {
    if (annotation != null) {
      context.read<DrawCubit>().update(UpdateFillLayerModel(fill: annotation as Fill, fillColor: AppColors.veryPeri900, outlineColor: AppColors.veryPeri900, opacity: 0.7));
    }
  }


}