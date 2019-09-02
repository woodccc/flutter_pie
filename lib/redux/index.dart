import 'package:flutter/material.dart';

import 'package:flutter_pie/redux/theme_data_redux.dart';

class APPState {
  ThemeData themeData;

  APPState({this.themeData});
}

APPState appReducer(APPState state, action) {
  return APPState(
    themeData: ThemeDataReducer(state.themeData, action),
  );
}