import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/presentation/screens/main_screen/map/map_modes/map_interface.dart';

class MapCubit extends Cubit<MapInterface> {
  MapCubit(super.initialState);

  void push(MapInterface state) {
    emit(state);
  }
}