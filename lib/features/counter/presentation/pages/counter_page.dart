import 'package:flutter/material.dart';
import 'package:test1/features/counter/presentation/widgets/counter_widget.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const CounterWidget(),
    );
  }
}
