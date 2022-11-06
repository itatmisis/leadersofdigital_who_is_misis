import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/presentation/screens/main_screen/map/map_modes/layers_state.dart';

class DrawCubit extends Cubit<LayerState> {
  List<LayerModel> layers = [];

  DrawCubit(super.initialState);

  void draw(){
    emit(LayerState(layers));
  }

  void update(UpdateFillLayerModel m) {
    emit(LayerState([m]));
  }

}