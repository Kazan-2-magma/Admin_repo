import 'package:cinq_etoils/model/project_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServiceProject{
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  
  Future<String?> addProject(Projet projet) async{
    try{
      await _firebaseFirestore.collection("projects")
          .doc().set(projet.toJson());
      return "Project Added successfuly";
    }catch (e){
      print("Erreur lors de l\'ajout du projet: $e");
      return "Erreur lors de l\'ajout du projet: $e";
    }
  }

  Future<List<Map<String,dynamic>>> getProjects() async{
    try{
      QuerySnapshot querySnapshot = await _firebaseFirestore.collection("project").get();
      return querySnapshot.docs.map((e){
        return Projet(
            id: e.id,
            nomProjet: e["nomProjet"],
            description : e["description"],
            projetUrl: e["projetUrl"]
        ).toJson();
      }).toList();
    }catch (e){
      print("Error ${e.toString()}");
      return [];
    }
  }
}