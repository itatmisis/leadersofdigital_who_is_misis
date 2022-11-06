import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/data/api/api.dart';
import 'package:frontend/data/storage/storage.dart';

enum DownloadedState { none, inProgress, downloaded }

class PolygonLoaderCubit extends Cubit<DownloadedState> {
  PolygonLoaderCubit(super.initialState);

  void load(DownloadedState state) async {
   emit(state);
  }
}
