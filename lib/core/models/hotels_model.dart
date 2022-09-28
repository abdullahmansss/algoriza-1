import 'package:test1/core/models/hotel_model.dart';
import 'package:test1/core/models/status_model.dart';
import 'package:test1/core/models/user_model.dart';

class HotelsModel {
  final StatusModel status;
  final HotelsDataModel? data;

  HotelsModel({
    required this.status,
    required this.data,
  });

  factory HotelsModel.fromJson(Map<String, dynamic> json) {
    return HotelsModel(
      status: StatusModel.fromJson(json['status']),
      data: HotelsDataModel.fromJson(json['data']),
    );
  }
}

class HotelsDataModel {
  final List<HotelModel> data;
  final int lastPage;
  final int total;

  HotelsDataModel({
    required this.data,
    required this.lastPage,
    required this.total,
  });

  factory HotelsDataModel.fromJson(Map<String, dynamic> json) {
    return HotelsDataModel(
      lastPage: json['last_page'],
      total: json['total'],
      data: List<HotelModel>.from(
        json['data'].map(
          (x) => HotelModel.fromJson(x),
        ),
      ),
    );
  }
}