class Attach{
  String? id;
  String? id_project;
  String? id_client;
  Attach({
    this.id = "",
    required this.id_client,
    required this.id_project,
  });

  Map<String, dynamic> toJson({String uid = ""}) {
    return {
      "id" : uid,
      'projetId': id_project,
      'clientId': id_client,
    };
  }

  factory Attach.fromJson(Map<String, dynamic> json) {
    return Attach(
      id: json['id'],
      id_project: json['projetId'],
      id_client: json['clientId'],
    );
  }
}