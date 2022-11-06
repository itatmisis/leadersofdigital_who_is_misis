import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/data/api/api.dart';
import 'package:frontend/data/storage/storage.dart';

enum DownloadedState { none, inProgress, downloaded }

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

      Storage().lands = await Api().getLands();
      Storage().capitals = await Api().getCapital();
      Storage().organizations = await Api().getOrganizations();
      Storage().sanitaries = await Api().getSanitary();
      Storage().starts = await Api().getStartGrounds();

      downloaded = DownloadedState.downloaded;
      emit(downloaded);
    }
  }
}
