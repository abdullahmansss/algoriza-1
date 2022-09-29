import 'package:test1/core/models/hotel_model.dart';
import 'package:test1/core/models/status_model.dart';
import 'package:test1/core/models/user_model.dart';

class FacilitiesModel {
  final StatusModel status;
  final List<FacilitiesDataModel>? data;

  FacilitiesModel({
    required this.status,
    required this.data,
  });

  factory FacilitiesModel.fromJson(Map<String, dynamic> json) {
    return FacilitiesModel(
      status: StatusModel.fromJson(json['status']),
      data: List<FacilitiesDataModel>.from(
        json['data'].map(
          (x) => FacilitiesDataModel.fromJson(x),
        ),
      ),
    );
  }
}

class FacilitiesDataModel {
  final int id;
  final String name;
  final String image;

  FacilitiesDataModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory FacilitiesDataModel.fromJson(Map<String, dynamic> json) {
    return FacilitiesDataModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}