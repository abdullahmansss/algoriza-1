import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/core/util/blocs/app/cubit.dart';
import 'package:test1/core/util/blocs/app/states.dart';
import 'package:test1/core/util/routes.dart';
import 'package:test1/main.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppStates>(
      listener: (context, state) {
        if (state is ErrorState) {
          debugPrint(state.exception.message.toString());
          debugPrint(state.exception.error.toString());
          debugPrint(state.exception.code.toString());
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MaterialButton(
              onPressed: () {
                AppBloc.get(context).userLogin();
              },
              child: const Text('Login'),
            ),
            MaterialButton(
              onPressed: () {
                AppBloc.get(context).userProfile();
              },
              child: const Text('Get Profile'),
            ),
            MaterialButton(
              onPressed: () {
                AppBloc.get(context).getHotels();
              },
              child: const Text('Get Hotels'),
            ),
            MaterialButton(
              onPressed: () {
                context.push = Routes.explore;
              },
              child: const Text('Explore'),
            ),
            MaterialButton(
              onPressed: () {
                context.push = Routes.search;
              },
              child: const Text('Search'),
            ),
            if (AppBloc.get(context).profileModel != null)
              Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  color: Colors.red,
                  image: DecorationImage(
                    image: NetworkImage(
                        AppBloc.get(context).profileModel!.data!.image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            MaterialButton(
              onPressed: () {
                AppBloc.get(context).pickImage();
              },
              child: const Text('Pick Image'),
            ),
            if (AppBloc.get(context).image != null)
              Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  color: Colors.red,
                  image: DecorationImage(
                    image: FileImage(File(AppBloc.get(context).image!.path)),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            MaterialButton(
              onPressed: () {
                AppBloc.get(context).updateProfile();
              },
              child: const Text('Update Profile'),
            ),
          ],
        );
      },
    );
  }
}
