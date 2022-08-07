import 'package:flutter/material.dart';
import 'package:test1/core/util/widgets/primary_task_item.dart';

class FavoritesWidget extends StatelessWidget {
  const FavoritesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => PrimaryTaskItem(
        index: index,
      ),
      itemCount: 6,
    );
  }
}
