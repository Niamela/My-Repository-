class UserModel {
  String? name;
  String? email;
  String? mobileNumber;

  UserModel({this.name, this.email, this.mobileNumber});

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      mobileNumber: json['mobileNumber'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'mobileNumber': mobileNumber};
  }
}
