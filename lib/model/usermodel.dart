class UserModel {
  String? name;
  String? email;
  String? mobileNumber;
  String? address;
  String? about_company;
  List? services;
  String? displayPicture;
  List? websites;

  UserModel(
      {this.name,
      this.email,
      this.mobileNumber,
      this.about_company,
      this.address,
      this.services,
      this.displayPicture,
      this.websites});

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      mobileNumber: json['mobileNumber'],
      about_company: json['about_company'],
      displayPicture: json["displayPicture"],
      address: json['address'],
      services: json['services'] ?? [],
      websites: json['websites'] ?? [],
      // products: List<ProductModel>.from(
      //     json["products"]!.map((x) => ProductModel.fromMap(x)))
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'mobileNumber': mobileNumber,
      'address': address,
      'about_company': about_company,
      'services': services,
      'websites': websites,
      "displayPicture": displayPicture,
    };
  }
}

class ProductModel {
  String? name;
  String? image;

  ProductModel({this.name, this.image});

  factory ProductModel.fromMap(Map<String, dynamic> json) {
    return ProductModel(name: json['name'], image: json['image']);
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'image': image};
  }
}
