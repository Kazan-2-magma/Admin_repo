class Projet {
  String id = "";
  String nomProjet;
  String emailProfessionel;
  String phoneNumber;
  String projetUrl = "";

  Projet({
    this.id = "",
    required this.emailProfessionel,
    required this.nomProjet,
    required this.phoneNumber,
    this.projetUrl = "",
  });

  Map<String, dynamic> toJson({String id = ""}) {
    return {
      "id" : id,
      'nomProjet': nomProjet,
      'projetUrl': projetUrl,
      "phoneNumber" : phoneNumber,
      "email_professionel" : emailProfessionel,
    };
  }

  factory Projet.fromJson(Map<String, dynamic> json) {
    return Projet(
      id: json['id'],
      emailProfessionel : json["email_professionel"],
      phoneNumber: json["phoneNumber"],
      nomProjet: json['nomProjet'],
      projetUrl: json['projetUrl'],
    );
  }
}
