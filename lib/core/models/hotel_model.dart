class HotelModel {
  final int id;
  final String name;
  final String description;

  HotelModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}