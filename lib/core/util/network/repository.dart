import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:test1/core/error/exceptions.dart';
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

  Future<Either<PrimaryServerException, HotelsModel>> getHotels({
    required int page,
  });
}

class RepositoryImplementation extends Repository {
  final DioHelper dioHelper;

  RepositoryImplementation({
    required this.dioHelper,
  });

  @override
  Future<Either<PrimaryServerException, HotelsModel>> getHotels({
  required int page,
}) async {
    return basicErrorHandling<HotelsModel>(
      onSuccess: () async {
        final response = await dioHelper.get(
          endPoint: hotelsEndPoint,
          query: {
            'page': page,
            'count': 10,
          }
        );

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
