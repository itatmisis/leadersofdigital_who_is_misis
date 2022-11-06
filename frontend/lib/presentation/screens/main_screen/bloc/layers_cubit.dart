import 'package:flutter_bloc/flutter_bloc.dart';


class LayersCubit extends Cubit<List<bool>> {
  LayersCubit(super.initialState);

  void setLayers(List<bool> layers) {
    final List<bool> n = [];
    n.addAll(layers);
    emit(n);
  }
}