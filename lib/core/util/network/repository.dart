import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test1/core/error/exceptions.dart';
import 'package:test1/core/models/facilities_model.dart';
import 'package:test1/core/models/hotels_model.dart';
import 'package:test1/core/models/login_model.dart';
import 'package:test1/core/models/profile_model.dart';
import 'package:test1/core/util/network/remote/dio_helper.dart';
import 'package:test1/core/util/network/remote/end_points.dart';

abstract class Repository {
  Future<Either<PrimaryServerException, LoginModel>> login({
    required String email,
    required String password,
  });

  Future<Either<PrimaryServerException, ProfileModel>> getProfile({
    required String token,
  });

  Future<Either<PrimaryServerException, ProfileModel>> updateProfile({
    required String token,
    required String name,
    required String email,
    required File image,
  });

  Future<Either<PrimaryServerException, HotelsModel>> getHotels({
    required int page,
  });

  Future<Either<PrimaryServerException, HotelsModel>> searchHotels({
    required Map<String, int> facilities,
    required String name,
  });

  Future<Either<PrimaryServerException, FacilitiesModel>> getFacilities();
}

class RepositoryImplementation extends Repository {
  final DioHelper dioHelper;

  RepositoryImplementation({
    required this.dioHelper,
  });

  @override
  Future<Either<PrimaryServerException, HotelsModel>> searchHotels({
    required Map<String, int> facilities,
    required String name,
  }) async {
    return basicErrorHandling<HotelsModel>(
      onSuccess: () async {
        final response = await dioHelper.get(
          endPoint: searchEndPoint,
          query: {
            'name': name,
            ...facilities,
            'count': 10,
            'page': 1,
          },
        );

        return HotelsModel.fromJson(response);
      },
      onPrimaryServerException: (e) async {
        return e;
      },
    );
  }

  @override
  Future<Either<PrimaryServerException, FacilitiesModel>>
      getFacilities() async {
    return basicErrorHandling<FacilitiesModel>(
      onSuccess: () async {
        final response = await dioHelper.get(
          endPoint: facilitiesEndPoint,
        );

        return FacilitiesModel.fromJson(response);
      },
      onPrimaryServerException: (e) async {
        return e;
      },
    );
  }

  @override
  Future<Either<PrimaryServerException, HotelsModel>> getHotels({
    required int page,
  }) async {
    return basicErrorHandling<HotelsModel>(
      onSuccess: () async {
        final response = await dioHelper.get(endPoint: hotelsEndPoint, query: {
          'page': page,
          'count': 4,
        });

        return HotelsModel.fromJson(response);
      },
      onPrimaryServerException: (e) async {
        return e;
      },
    );
  }

  @override
  Future<Either<PrimaryServerException, ProfileModel>> getProfile({
    required String token,
  }) async {
    return basicErrorHandling<ProfileModel>(
      onSuccess: () async {
        final response = await dioHelper.get(
          endPoint: profileEndPoint,
          token: token,
        );

        return ProfileModel.fromJson(response);
      },
      onPrimaryServerException: (e) async {
        return e;
      },
    );
  }

  @override
  Future<Either<PrimaryServerException, ProfileModel>> updateProfile({
    required String token,
    required String name,
    required String email,
    required File image,
  }) async {
    return basicErrorHandling<ProfileModel>(
      onSuccess: () async {
        final response = await dioHelper.post(
          endPoint: updateProfileEndPoint,
          token: token,
          isMultipart: true,
          data: FormData.fromMap({
            'name': name,
            'email': email,
            'image': await MultipartFile.fromFile(
              image.path,
              filename: Uri.file(image.path).pathSegments.last,
            ),
          }),
        );

        return ProfileModel.fromJson(response);
      },
      onPrimaryServerException: (e) async {
        return e;
      },
    );
  }

  @override
  Future<Either<PrimaryServerException, LoginModel>> login({
    required String email,
    required String password,
  }) async {
    return basicErrorHandling<LoginModel>(
      onSuccess: () async {
        final response = await dioHelper.post(
          endPoint: loginEndPoint,
          data: {
            'email': email,
            'password': password,
          },
        );

        return LoginModel.fromJson(response);
      },
      onPrimaryServerException: (e) async {
        return e;
      },
    );
  }
}

extension on Repository {
  Future<Either<PrimaryServerException, T>> basicErrorHandling<T>({
    required Future<T> Function() onSuccess,
    Future<PrimaryServerException> Function(PrimaryServerException exception)?
        onPrimaryServerException,
  }) async {
    try {
      final r = await onSuccess();
      return Right(r);
    } on PrimaryServerException catch (e, s) {
      debugPrint(s.toString());
      return Left(e);
    }
  }
}
