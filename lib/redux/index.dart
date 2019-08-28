import 'package:flutter/material.dart';

class ThemeColorState {
  final dynamic _themeColor;
  get themeColor => _themeColor;

  ThemeColorState(this._themeColor);

  ThemeColorState.initState() : _themeColor = Colors.blue;
}

enum ThemeColorActions { updateThemeColor }

ThemeColorState reducer(ThemeColorState state, action) {
  if (action == ThemeColorActions.updateThemeColor) {
    return ThemeColorState(Colors.red);
  }
}