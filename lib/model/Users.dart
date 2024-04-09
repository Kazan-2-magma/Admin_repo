import 'package:cinq_etoils/model/UserModel.dart';

class AdminUser extends UserModel {
  String id_user = "";
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  String photoUrl;
  String role;
  String password;

  AdminUser({
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.email,
      required this.photoUrl,
      required this.role,
      required this.password,
      String   this.id_user = ""
}):super(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      email: email,
      photoUrl: photoUrl,
      role: role,
      password: password,
      id_user: id_user
  );
  @override
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
  factory AdminUser.fromJson(Map<String, dynamic>? json) {
    return AdminUser(
      id_user: json!['id_user'] ?? "",
      firstName: json['firstName']?? "",
      lastName: json['lastName']?? "",
      phoneNumber: json['phoneNumber']?? "",
      email: json['email']?? "",
      photoUrl: json['photoUrl']?? "",
      role:json['role']?? "",
      password: json['password']?? "",
    );
  }

}

class Users extends UserModel {
  String id_user;
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  String photoUrl;
  String idProjet;
  String role;
  String password;

  Users({
    required this.id_user,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.photoUrl,
    required this.idProjet,
    required this.role,
    required this.password
  }):super(
      id_user: id_user,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      email: email,
      photoUrl: photoUrl,
      role: role,
      password: password
  );

  Map<String, dynamic> toJson({String uid = ""}) {
    return {
      "id_user" : uid,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber':phoneNumber,
      'email': email,
      'photoUrl': photoUrl,
      'idProjet': idProjet,
      'role':role,
      'password' :password
    };
  }
  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id_user: json['id_user'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      photoUrl: json['photoUrl'],
      idProjet: json['idProjet'],
      role:json['role'],
      password: json['password'],
    );
  }

}

