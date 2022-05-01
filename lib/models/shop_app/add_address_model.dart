class AddAddressModel {
  bool? status;
  String? message;
  Data? data;

  AddAddressModel({this.status, this.message, this.data});

  AddAddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  String? name;
  String? city;
  String? region;
  String? details;
  double? latitude;
  double? longitude;
  String? notes;
  int? id;

  Data(
      {this.name,
        this.city,
        this.region,
        this.details,
        this.latitude,
        this.longitude,
        this.notes,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    city = json['city'];
    region = json['region'];
    details = json['details'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    notes = json['notes'];
    id = json['id'];
  }

}
