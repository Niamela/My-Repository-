class UserModel {
  String? name;
  String? email;
  String? mobileNumber;
  String? address;
  String? about_company;
  List? services;

  UserModel(
      {this.name,
      this.email,
      this.mobileNumber,
      this.about_company,
      this.address,
      this.services});

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
        name: json['name'],
        email: json['email'],
        mobileNumber: json['mobileNumber'],
        about_company: json['about_company'],
        address: json['address'],
        services: json['services'] ?? []);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'mobileNumber': mobileNumber,
      'address': address,
      'about_company': about_company,
      'services': services
    };
  }
}
