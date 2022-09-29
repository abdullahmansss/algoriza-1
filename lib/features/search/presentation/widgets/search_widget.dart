import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/core/util/blocs/app/cubit.dart';
import 'package:test1/core/util/blocs/app/states.dart';
import 'dart:math' as math;

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    AppBloc.get(context).getFacilities();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppStates>(
      listener: (context, state) {
        if (state is ErrorState) {}
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              if (AppBloc.get(context).facilitiesModel != null)
                Wrap(
                  runSpacing: 16.0,
                  spacing: 16.0,
                  children: [
                    ...AppBloc.get(context)
                        .facilitiesModel!
                        .data!
                        .asMap()
                        .map(
                          (key, value) => MapEntry(
                            key,
                            InkWell(
                              onTap: () {
                                AppBloc.get(context).selectFacility(value.id);
                              },
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 80.0,
                                height: 80.0,
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: AppBloc.get(context)
                                          .selectedFacilities
                                          .any((element) => element == value.id)
                                      ? Colors.teal
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Image.network(value.image),
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(
                                      value.name,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        .values
                        .toList(),
                  ],
                ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: AppBloc.get(context).searchController,
                decoration: const InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              MaterialButton(
                color: Colors.teal,
                onPressed: () {
                  AppBloc.get(context).searchHotels();
                },
                child: const Text('Search'),
              ),
              const SizedBox(
                height: 16.0,
              ),
              if(AppBloc.get(context).searchHotelsModel != null)
                Text(AppBloc.get(context).searchHotelsModel!.data!.data.length.toString()),
              if(AppBloc.get(context).searchHotelsModel != null)
                Expanded(
                  child: ListView.separated(
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
                                        'http://api.mahmoudtaha.com/images/${AppBloc.get(context).searchHotelsModel!.data!.data[index].images[math.Random().nextInt(AppBloc.get(context).searchHotelsModel!.data!.data[index].images.length)]}'),
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
                                          AppBloc.get(context).searchHotelsModel!.data!.data[index].name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '${AppBloc.get(context).searchHotelsModel!.data!.data[index].price}\$',
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
                                        AppBloc.get(context).searchHotelsModel!.data!.data[index].rate,
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
                    itemCount: AppBloc.get(context).searchHotelsModel!.data!.data.length,
                  ),
                ),
              if(state is SearchLoadingState)
                const CupertinoActivityIndicator(),
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
