import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:test1/core/models/current_weather_model.dart';
import 'package:test1/core/models/hotel_model.dart';
import 'package:test1/core/models/login_model.dart';
import 'package:test1/core/models/profile_model.dart';
import 'package:test1/core/models/task_model.dart';
import 'package:test1/core/util/blocs/app/states.dart';
import 'package:test1/core/util/network/remote/dio_helper.dart';
import 'package:test1/core/util/network/remote/end_points.dart';
import 'package:test1/core/util/network/repository.dart';

class AppBloc extends Cubit<AppStates> {
  final Repository repository;

  AppBloc({
    required this.repository,
  }) : super(AppInitialState());

  static AppBloc get(context) => BlocProvider.of<AppBloc>(context);

  LoginModel? loginModel;

  void userLogin() async {
    emit(UserLoginLoadingState());

    final response = await repository.login(
      email: 'abdullah.mansour@gmail.com',
      password: '123456',
    );

    response.fold(
      (l) {
        emit(ErrorState(exception: l));
      },
      (r) {
        loginModel = r;

        emit(UserLoginSuccessState());
      },
    );
  }

  ProfileModel? profileModel;

  void userProfile() async {
    emit(UserProfileLoadingState());

    final response = await repository.getProfile(
      token: loginModel!.data!.token,
    );

    response.fold(
          (l) {
        emit(ErrorState(exception: l));
      },
          (r) {
            profileModel = r;

        emit(UserProfileSuccessState());
      },
    );
  }

  List<HotelModel> hotels = [];
  int lastPage = 1;
  int total = 0;
  int currentPage = 1;

  void getHotels({
  bool isForce = false,
}) async {
    emit(HotelsLoadingState());

    if(isForce) {
      hotels = [];
      currentPage = 1;
    }

    final response = await repository.getHotels(
      page: currentPage,
    );

    response.fold(
          (l) {
        emit(ErrorState(exception: l));
      },
          (r) {
            hotels.addAll(r.data!.data);

            currentPage++;

            if(lastPage == 1) {
              lastPage = r.data!.lastPage;
              total = r.data!.total;
            }

            isEnd = false;

        emit(HotelsSuccessState());
      },
    );
  }

  bool isEnd = false;

  void toggleIsEnd() {
    isEnd = !isEnd;

    emit(ToggleIsEndState());
  }
}
