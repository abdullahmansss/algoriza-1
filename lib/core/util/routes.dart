import 'package:flutter/material.dart';
import 'package:test1/features/home/presentation/pages/home_page.dart';

class Routes {
  static const String home = '/home';

  static Map<String, WidgetBuilder> get routes {
    return {
      home: (context) => const HomePage(),
    };
  }
}