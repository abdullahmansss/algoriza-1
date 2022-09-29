import 'package:flutter/material.dart';
import 'package:test1/features/explore/presentation/pages/explore_page.dart';
import 'package:test1/features/home/presentation/pages/home_page.dart';
import 'package:test1/features/search/presentation/pages/search_page.dart';

class Routes {
  static const String home = '/home';
  static const String explore = '/explore';
  static const String search = '/search';

  static Map<String, WidgetBuilder> get routes {
    return {
      home: (context) => const HomePage(),
      explore: (context) => const ExplorePage(),
      search: (context) => const SearchPage(),
    };
  }
}