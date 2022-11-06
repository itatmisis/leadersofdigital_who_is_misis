import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/presentation/screens/main_screen/topbars/top_bar_state.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class TopBarCubit extends Cubit<TopBarState> {
  TopBarState topBarState = MainTopBarState as TopBarState;

  TopBarCubit(super.initialState);

  void paintMain() {
    emit(MainTopBarState());
  }

  void paintChose(List<LatLng> points) {
    emit(ChooseTopBarState(points: points));
  }

  void paintBbox() {
    emit(BboxTopBarState());
  }
}
