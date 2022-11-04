import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/domain/models/area_model.dart';

class SidebarCubit extends Cubit<AreaModel?> {
  SidebarCubit(super.initialState);

  void setCurrentArea(AreaModel? areaModel) {
    emit(areaModel);
  }
  void disableArea(){
    emit(null);
  }
}