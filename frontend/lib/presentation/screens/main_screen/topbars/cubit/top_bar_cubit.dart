import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/presentation/screens/main_screen/topbars/cubit/top_bar_state.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class TopBarCubit extends Cubit<TopBarState> {
  TopBarCubit(super.initialState);

  void paintMain() {
    emit(MainTopBarState());
  }

  void paintChoseAfterFirstPoint(LatLng point) {
    emit(ChooseTopBarState(
        p1: point, p2: null, isBeginEnabled: false, isContinueEnabled: true));
  }

  void paintChoseAfterSecondPoint(LatLng p1, LatLng p2) {
    emit(ChooseTopBarState(
        p1: p1, p2: p2, isBeginEnabled: true, isContinueEnabled: false));
  }

  void paintBbox() {
    emit(BboxTopBarState());
  }
  void returnToPrevious(TopBarState state){
    emit(state);
  }
}
