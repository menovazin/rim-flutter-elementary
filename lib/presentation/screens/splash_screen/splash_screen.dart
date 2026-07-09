import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import 'splash_screen_widget_model.dart';

class SplashScreen extends ElementaryWidget<ISplashWidgetModel> {
  const SplashScreen({
    WidgetModelFactory wmFactory = splashWidgetModelFactory,
    super.key,
  }) : super(wmFactory);

  @override
  Widget build(ISplashWidgetModel wm) {
    return Scaffold(
      body: Center(
        child: Text(
          wm.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
