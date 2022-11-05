import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/data/storage/storage.dart';
import 'package:frontend/domain/models/geographic_model.dart';

class LayersCubit extends Cubit<List<Map<int, GeographicModel>>> {
  LayersCubit(super.initialState);

  final Map<int, Map<int, GeographicModel>> layersData = {
    0: Storage().lands,
    1: Storage().capitals,
    2: Storage().organizations,
    3: Storage().sanitaries,
    4: Storage().starts
  };

  void setLayers(List<int> layers) {
    final List<Map<int, GeographicModel>> result = [];

    for (var l in layers) {
      result.add(layersData[l]!);
    }

    emit(result);
  }
}