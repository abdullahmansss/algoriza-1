import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/core/util/blocs/app/cubit.dart';
import 'package:test1/core/util/blocs/app/states.dart';
import 'dart:math' as math;

class ExploreWidget extends StatefulWidget {
  const ExploreWidget({Key? key}) : super(key: key);

  @override
  State<ExploreWidget> createState() => _ExploreWidgetState();
}

class _ExploreWidgetState extends State<ExploreWidget> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    AppBloc.get(context).getHotels(
      isForce: true,
    );

    scrollController.addListener(() {
      if(scrollController.position.extentAfter == 0 && !AppBloc.get(context).isEnd &&
      AppBloc.get(context).lastPage >= AppBloc.get(context).currentPage)
      {
        debugPrint('maxScrollExtent');
        AppBloc.get(context).toggleIsEnd();
        AppBloc.get(context).getHotels();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppStates>(
      listener: (context, state) {
        if (state is ErrorState) {}
      },
      builder: (context, state) {
        return CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverPersistentHeader(
              pinned: false,
              delegate: SliverAppBarDelegate(
                minHeight: 55.0,
                maxHeight: 55.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey[300]!,
                                width: 1,
                              ),
                            ),
                            padding: const EdgeInsets.all(16.0),
                            child: const Text(
                              'Search',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey[300]!,
                              width: 1,
                            ),
                          ),
                          padding: const EdgeInsets.all(14.0),
                          child: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(height: 16),
                ],
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: SliverAppBarDelegate(
                minHeight: 30.0,
                maxHeight: 30.0,
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  height: 30.0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: Text(
                    '${AppBloc.get(context).total} Hotel',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black45,
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  if(AppBloc.get(context).hotels.isNotEmpty)
                    ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                      ),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[300]!,
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 200,
                              child: Stack(
                                children: [
                                  Image(
                                    image: NetworkImage(
                                        'http://api.mahmoudtaha.com/images/${AppBloc.get(context).hotels[index].images[math.Random().nextInt(AppBloc.get(context).hotels[index].images.length)]}'),
                                    width: double.infinity,
                                    height: 200.0,
                                    fit: BoxFit.cover,
                                  ),
                                  // Container(
                                  //   width: double.infinity,
                                  //   height: 200,
                                  //   color: Colors.black38,
                                  // ),
                                  // Align(
                                  //   alignment: Alignment.bottomLeft,
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.all(8.0),
                                  //     child: Row(
                                  //       children: [
                                  //         Container(
                                  //           width: 40.0,
                                  //           height: 40.0,
                                  //           decoration: BoxDecoration(
                                  //             color: Colors.white,
                                  //             borderRadius: BorderRadius.circular(10),
                                  //           ),
                                  //           child: const Icon(
                                  //             Icons.ac_unit,
                                  //             color: Colors.grey,
                                  //           ),
                                  //         ),
                                  //         const SizedBox(
                                  //           width: 8.0,
                                  //         ),
                                  //         Container(
                                  //           width: 40.0,
                                  //           height: 40.0,
                                  //           decoration: BoxDecoration(
                                  //             color: Colors.white,
                                  //             borderRadius: BorderRadius.circular(10),
                                  //           ),
                                  //           child: const Icon(
                                  //             Icons.ac_unit,
                                  //             color: Colors.grey,
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          AppBloc.get(context).hotels[index].name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '${AppBloc.get(context).hotels[index].price}\$',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star_rate_rounded,
                                        color: Colors.amber,
                                        size: 24,
                                      ),
                                      Text(
                                        AppBloc.get(context).hotels[index].rate,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemCount: AppBloc.get(context).hotels.length,
                  ),
                  if(AppBloc.get(context).hotels.isEmpty)
                    const CupertinoActivityIndicator(),
                  if(AppBloc.get(context).isEnd)
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 14.0,
                        bottom: 100.0,
                      ),
                      child: CupertinoActivityIndicator(),
                    ),
                ],
              ),
            ),
          ],
        );

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: const Text(
                          'Search',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                      padding: const EdgeInsets.all(14.0),
                      child: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                '540 Hotel',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black45,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) => Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300]!,
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Column(
                        children: [
                          const Image(
                            image: NetworkImage(
                                'https://cdn.britannica.com/96/115096-050-5AFDAF5D/Bellagio-Hotel-Casino-Las-Vegas.jpg'),
                            width: double.infinity,
                            height: 200.0,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Row(
                                  children: const [
                                    Expanded(
                                      child: Text(
                                        'Bellagio Hotel & Casino',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '200\$',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.star_rate_rounded,
                                      color: Colors.amber,
                                      size: 24,
                                    ),
                                    Text(
                                      '4.5',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemCount: 10,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = shrinkOffset / maxExtent;

    // debugPrint('progress => $progress');

    return AnimatedContainer(
      duration: const Duration(seconds: 2),
      // height: progress,
      child: child,
    );
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
