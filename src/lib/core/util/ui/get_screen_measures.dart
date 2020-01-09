import 'package:flutter/material.dart';

class ScreenProperties {
  final BuildContext context;
  double height;
  double width;
  EdgeInsets padding;

  ScreenProperties(this.context) {
    this.height = MediaQuery.of(context).size.height;
    this.width = MediaQuery.of(context).size.width;
    this.padding = MediaQuery.of(context).padding;
  }

  double getHeightWOutSafeArea() {
    return height - padding.top - padding.bottom;
  }

  double getHeightWOutStatusBar() {
    return height - padding.top;
  }

  double getHeightWOutStatusAndToolBar() {
    return height - padding.top - kToolbarHeight;
  }
}
