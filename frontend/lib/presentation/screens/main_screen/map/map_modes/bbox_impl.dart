import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/data/storage/storage.dart';
import 'package:frontend/presentation/screens/main_screen/map/map_modes/layers_state.dart';
import 'package:frontend/presentation/screens/main_screen/map/map_modes/map_interface.dart';
import 'package:frontend/presentation/theme/app_colors.dart';
import 'package:mapbox_gl_platform_interface/mapbox_gl_platform_interface.dart';

import 'draw_cubit.dart';

class BBoxImpl extends MapInterface {
  @override
  void dispose(BuildContext context) {
    // TODO: implement dispose
  }

  @override
  void init(BuildContext context) {
    print('initBBoxLayer');
    context.read<DrawCubit>().layers.add(FillLayerModel(event: Storage().lands, fillColor: AppColors.dewberry400, onClick:  (_, fill) {
      onMapPressed(context, annotation: fill);
    }, outlineColor: AppColors.dewberry900, opacity: 0.3));
    context.read<DrawCubit>().draw();

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