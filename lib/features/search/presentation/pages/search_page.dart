import 'package:flutter/material.dart';
import 'package:test1/features/explore/presentation/widgets/explore_widget.dart';
import 'package:test1/features/home/presentation/widgets/home_widget.dart';
import 'package:test1/features/search/presentation/widgets/search_widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.map_outlined,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.filter_alt_outlined,
            ),
          ),
        ],
      ),
      body: const SearchWidget(),
    );
  }
}
