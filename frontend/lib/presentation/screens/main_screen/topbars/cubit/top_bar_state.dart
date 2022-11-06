import 'package:mapbox_gl/mapbox_gl.dart';

abstract class TopBarState {
  TopBarState();
}

class MainTopBarState extends TopBarState {
  MainTopBarState() : super();
}

class ChooseTopBarState extends TopBarState {
  LatLng? p1;
  LatLng? p2;
  bool isContinueEnabled;
  bool isBeginEnabled;

  ChooseTopBarState(
      {required this.p1,
      required this.p2,
      required this.isBeginEnabled,
      required this.isContinueEnabled})
      : super();
}

class BboxTopBarState extends TopBarState {
  BboxTopBarState() : super();
}
