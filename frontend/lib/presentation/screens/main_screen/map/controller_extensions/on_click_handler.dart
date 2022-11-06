import 'package:flutter/material.dart';
import 'package:frontend/presentation/theme/app_colors.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class OnClickHandler {
  static bool _isChosen = false;
  static bool get isChosen => _isChosen;

  static Fill? _currentFill;

  static Function(Fill)? _onClose;


  static void choose(Fill currentFill, {Function(Fill)? onChoose, Function(Fill)? onClose}) async {

    if (onChoose != null) {
      onChoose(currentFill);
    }

    _currentFill = currentFill;
    _isChosen = true;
    _onClose = onClose;
  }

  static void close() async {
    if (_onClose != null) {
      _onClose!(_currentFill!);
      _onClose = null;
    }

    _currentFill = null;
    _isChosen = false;
  }
}