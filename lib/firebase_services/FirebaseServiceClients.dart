import 'package:cinq_etoils/model/Client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServiceClients{
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference _collectionRefProject = FirebaseFirestore.instance.collection("projects");
  final CollectionReference _collectionReference = FirebaseFirestore.instance.collection("clients");
  final CollectionReference _collectionAttach = FirebaseFirestore.instance.collection("attachment");
  static int countClinents = 0;

  Future<String?> addClient(Client client)async{
    try{
      String id = _collectionReference.doc().id;
      await _collectionReference
          .doc(id).set(client.toJson(uid: id));
      return id;
    }catch(e){
      return "Error adding new client";
    }
  }

  Future<void> updateClient(String client_id,Client client)async{
    try{
      await _collectionReference.doc(client_id).update(client.toJson());
    }catch(e){
      throw Exception(e);
    }
  }

  Future<List<Client>> getClientsWithProject(String project_id)async{
    try{
      QuerySnapshot attachQuery = await _collectionAttach
      .where("projetId",isEqualTo: project_id)
      .get();
      List clientsID = attachQuery.docs.map((e) => e["clientId"]).toList();
      QuerySnapshot querySnapshot = await _collectionReference
          .where(FieldPath.documentId,whereIn: clientsID)
          .get();
      return querySnapshot.size != 0
          ? querySnapshot.docs.map((e){
        return Client(
            firstName: e["firstName"],
            lastName: e["lastName"],
            email: e["email"],
            phoneNumber: e["phoneNumber"]
        );
      }).toList()
          : [];
    }catch(e){
      throw Exception(e);
    }
  }

  Future<void> deleteClient(String id)async{
    try{
      await _collectionReference.doc(id).delete();
    }catch(e){
      print("Error deletion");
    }
  }


  Future<List<Client>?> getClients()async {
    try{
        QuerySnapshot querySnapshot = await _collectionReference.get();
        countClinents = querySnapshot.size;
        return querySnapshot.docs.map((e){
          return Client(
            id: e.id,
            firstName: e["firstName"],
            lastName: e["lastName"],
            email: e["email"],
            phoneNumber: e["phoneNumber"],
          );
        }).toList();
    }catch(e){
      print("No Client Found");
        return [];
    }
  }
}