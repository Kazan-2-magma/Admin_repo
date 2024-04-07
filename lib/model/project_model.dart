class Projet {
  String id;
  String nomProjet;
  String description;
  String projetUrl = "";

  Projet({
    required this.id,
    required this.description,
    required this.nomProjet,
    this.projetUrl = "",
  });

  Map<String, dynamic> toJson() {
    return {
      'nomProjet': nomProjet,
      'projetUrl': projetUrl,
      "description" : description,
    };
  }

  factory Projet.fromJson(Map<String, dynamic> json) {
    return Projet(
      id: json['id'],
      description : json["description"],
      nomProjet: json['nomProjet'],
      projetUrl: json['projetUrl'],
    );
  }
}
