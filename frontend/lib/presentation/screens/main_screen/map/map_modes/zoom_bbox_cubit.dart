import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class ZoomBBoxState {
  ZoomBBoxState(this.cameraPosition, this.lb, this.rt, this.isScroll);
  CameraUpdate cameraPosition;
  LatLng lb, rt;
  bool isScroll;
}

class ZoomBBoxCubit extends Cubit<ZoomBBoxState> {
  ZoomBBoxCubit(super.initialState);

  void push(ZoomBBoxState state) {
    emit(state);
  }


}