import 'package:flutter/material.dart';
import 'package:test1/features/home/presentation/widgets/all_widget.dart';
import 'package:test1/features/home/presentation/widgets/completed_widget.dart';
import 'package:test1/features/home/presentation/widgets/favorites_widget.dart';
import 'package:test1/features/home/presentation/widgets/un_completed_widget.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  // late TabController _tabController;

  @override
  void initState() {
    super.initState();

    // _tabController = TabController(
    //   length: 4,
    //   vsync: this,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          Container(
            height: 0.6,
            width: double.infinity,
            color: Colors.grey[500],
          ),
          const TabBar(
            // controller: _tabController,
            labelColor: Colors.black87,
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.black87,
            indicatorWeight: 3,
            labelStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            tabs: [
              Tab(
                text: 'All',
              ),
              Tab(
                text: 'Completed',
              ),
              Tab(
                text: 'Un Completed',
              ),
              Tab(
                text: 'Favorites',
              ),
            ],
          ),
          Container(
            height: 0.6,
            width: double.infinity,
            color: Colors.grey[500],
          ),
          const Expanded(
            child: TabBarView(
              // controller: _tabController,
              children: [
                AllWidget(),
                CompletedWidget(),
                UnCompletedWidget(),
                FavoritesWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
