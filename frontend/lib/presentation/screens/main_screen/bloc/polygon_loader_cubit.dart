import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/data/api/api.dart';
import 'package:frontend/data/storage/storage.dart';
import 'package:frontend/domain/models/area_model.dart';
import 'package:frontend/domain/models/land_model.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

enum DownloadedState {
  none,
  inProgress,
  downloaded
}

class PolygonLoaderCubit extends Cubit<Map<int, AreaModel>?> {
  DownloadedState downloaded = DownloadedState.none;

  PolygonLoaderCubit(super.initialState);

  Future<Map<int, AreaModel>> _download() async {
    final polygons = await Api().getPolygons();

    Map<int, AreaModel> data = {};

    for (var p in polygons) {
      List<LatLng> geometry = [];
      for (var g in p['polygons'][0]) {
        geometry.add(LatLng(g[0], g[1]));
      }
      data[p['oid']] = LandModel(geometry: geometry);
    }

    return data;
  }

  Future<Map<int, AreaModel>> _loadFromStorage() async {
    return Storage().polygons;
  }


  void load() async {
    if (downloaded == DownloadedState.downloaded) {
      emit(await _loadFromStorage());
    } else if (downloaded == DownloadedState.none) {
      downloaded = DownloadedState.inProgress;
      Storage().polygons = await _download();
      emit(Storage().polygons);
      downloaded = DownloadedState.downloaded;
    }
  }
}