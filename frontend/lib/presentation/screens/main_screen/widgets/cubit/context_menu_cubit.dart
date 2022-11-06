import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

enum ContextMenuState {
  added,
  considered,
  deleted,
}

class ContextMenuCubit extends Cubit<ContextMenuState> {
  ContextMenuCubit(super.initialState);

  void tapAdd() {
    emit(ContextMenuState.added);
    log("EMITTED ADDED");
  }

  void tapDelete() {
    emit(ContextMenuState.deleted);
    log("EMITTED DELETE");
  }

  void tapConsider() {
    emit(ContextMenuState.considered);
    log("EMITTED CONSIDERED");
  }
}
