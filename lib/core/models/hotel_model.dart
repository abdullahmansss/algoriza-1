class HotelModel {
  final int id;
  final String name;
  final String description;
  final String price;
  final String address;
  final String latitude;
  final String longitude;
  final String rate;
  final List<String> images;

  HotelModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.rate,
    required this.images,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      rate: json['rate'],
      images: List<String>.from(json['hotel_images'].map((x) => x['image'])),
    );
  }
}