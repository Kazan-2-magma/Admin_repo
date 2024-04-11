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
      QuerySnapshot querySnapshot = await _firebaseFirestore.collection("projects").get();
      return querySnapshot.docs.map((e){
        return Projet(
            id: e.id,
            nomProjet: e["nomProjet"],
            emailProfessionel : e["email_professionel"],
            phoneNumber: e["phoneNumber"],
            projetUrl: e["projetUrl"]
        ).toJson();
      }).toList();
    }catch (e){
      print("Error ${e.toString()}");
      return [];
    }
  }
  
  Future<void> deleteProject(String project_id) async{
      try{
        await _firebaseFirestore.collection("projects")
            .doc(project_id).delete();
        print("Delete success");
      }catch(e){
        print("Error : Delete Failed!!");
      }
  }

  Future<void> updateProject(String projetId, Projet nouveauProjet) async {
    try{
      await _firebaseFirestore.collection('projects').doc(projetId).update({
        'nomProjet': nouveauProjet.nomProjet,
        'phoneNumber': nouveauProjet.phoneNumber,
        'email_professionel': nouveauProjet.emailProfessionel,
        'projetUrl': nouveauProjet.projetUrl,
      });
    }catch (e) {
      print('Erreur lors de la modification du projet: $e');
    }
  }
}