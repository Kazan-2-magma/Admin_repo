class UserModel {
  String id_user = "";
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  String photoUrl;
  String role;
  String password;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.photoUrl,
    required this.role,
    required this.password,
    String id_user =""
  });

  Map<String, dynamic> toJson({String uid = ""}) {
    return {
      "id_user" : uid,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber':phoneNumber,
      'email': email,
      'photoUrl': photoUrl,
      'role':role,
      'password' :password
    };
  }
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id_user: json['id_user'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      photoUrl: json['photoUrl'],
      role:json['role'],
      password: json['password'],
    );
  }

}