import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/data/storage/storage.dart';
import 'package:frontend/domain/models/geographic_model.dart';

class LayersCubit extends Cubit<List<int>> {
  LayersCubit(super.initialState);

  void setLayers(List<int> layers) {
    emit(layers);
  }
}