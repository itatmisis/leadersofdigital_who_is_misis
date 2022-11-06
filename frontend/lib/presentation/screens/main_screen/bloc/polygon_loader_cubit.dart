import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/data/api/api.dart';
import 'package:frontend/data/storage/storage.dart';
import 'package:frontend/domain/models/area_model.dart';
import 'package:frontend/domain/models/geographic_model.dart';
import 'package:frontend/domain/models/land_model.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

enum DownloadedState { none, inProgress, downloaded }

class PolygonLoaderCubit extends Cubit<DownloadedState> {
  PolygonLoaderCubit(super.initialState);

  void load(DownloadedState state) async {
   emit(state);
  }
}
