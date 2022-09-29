import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:test1/core/models/current_weather_model.dart';
import 'package:test1/core/models/facilities_model.dart';
import 'package:test1/core/models/hotel_model.dart';
import 'package:test1/core/models/hotels_model.dart';
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
      token: 'DnkaEA2eU1DNZmKIpx5I7u6ptaKeEGAA1nq4bFkClgBsYsWLyTMNsJD7O06u',
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

  ProfileModel? updateProfileModel;

  void updateProfile() async {
    emit(UserProfileUpdateLoadingState());

    final response = await repository.updateProfile(
      image: File(image!.path),
      name: profileModel!.data!.name,
      email: profileModel!.data!.email,
      token: 'DnkaEA2eU1DNZmKIpx5I7u6ptaKeEGAA1nq4bFkClgBsYsWLyTMNsJD7O06u',
    );

    response.fold(
      (l) {
        emit(ErrorState(exception: l));
      },
      (r) {
        updateProfileModel = r;

        emit(UserProfileUpdateSuccessState());
      },
    );
  }

  final ImagePicker _picker = ImagePicker();
  XFile? image;

  void pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = pickedFile;

      emit(PickImageSuccessState());
    }
  }

  FacilitiesModel? facilitiesModel;

  void getFacilities() async {
    emit(GetFacilitiesLoadingState());

    final response = await repository.getFacilities();

    response.fold(
      (l) {
        emit(ErrorState(exception: l));
      },
      (r) {
        facilitiesModel = r;

        emit(GetFacilitiesSuccessState());
      },
    );
  }

  List<int> selectedFacilities = [];

  void selectFacility(int id) {
    if (selectedFacilities.contains(id)) {
      selectedFacilities.remove(id);
    } else {
      selectedFacilities.add(id);
    }

    emit(SelectFacilityState());
  }

  TextEditingController searchController = TextEditingController();

  HotelsModel? searchHotelsModel;

  void searchHotels() async {
    emit(SearchLoadingState());

    final response = await repository.searchHotels(
      name: searchController.text.isEmpty ? '' : searchController.text,
      facilities: {
        ...selectedFacilities.asMap().map(
              (key, value) => MapEntry(
                'facilities[$key]',
                value,
              ),
            ),
      },
    );

    response.fold(
      (l) {
        emit(ErrorState(exception: l));
      },
      (r) {
        searchHotelsModel = r;

        emit(SearchSuccessState());
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

    if (isForce) {
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

        if (lastPage == 1) {
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
