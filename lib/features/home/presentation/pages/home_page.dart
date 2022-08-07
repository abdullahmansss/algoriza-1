import 'package:flutter/material.dart';
import 'package:test1/features/home/presentation/widgets/home_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Board',
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.calendar_month_rounded,
              color: Colors.black54,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: const HomeWidget(),
    );
  }
}
