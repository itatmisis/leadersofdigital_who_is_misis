import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/data/api/api.dart';
import 'package:frontend/data/storage/storage.dart';
import 'package:frontend/domain/models/area_model.dart';
import 'package:frontend/domain/models/geographic_model.dart';
import 'package:frontend/domain/models/land_model.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

enum DownloadedState {
  none,
  inProgress,
  downloaded
}

class PolygonLoaderCubit extends Cubit<DownloadedState> {
  DownloadedState downloaded = DownloadedState.none;

  PolygonLoaderCubit(super.initialState);

  // Future<List<Map<int, LandModel>>> _download() async {
  //
  //   return data;
  // }

  void load() async {
    if (downloaded == DownloadedState.downloaded) {
      emit(downloaded);
    } else if (downloaded == DownloadedState.none) {
      downloaded = DownloadedState.inProgress;
      emit(downloaded);
      //Storage().lands = await _download();
      downloaded = DownloadedState.downloaded;
      emit(downloaded);
    }
  }
}