import 'package:cinq_etoils/model/UserModel.dart';

class Client{
  String id;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;

  Client({
    this.id = "",
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
  });

  String getFullName() => "$firstName $lastName";
  Map<String, dynamic> toJson({String uid = ""}) {
    return {
      "id_client" : uid,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber':phoneNumber,
      'email': email,
    };
  }
  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id_client'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
    );
  }
}