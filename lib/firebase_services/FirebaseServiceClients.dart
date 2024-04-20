import 'package:cinq_etoils/model/Client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServiceClients{
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference _collectionReference = FirebaseFirestore.instance.collection("clients");

  Future<String?> addClient(Client client)async{
    try{
      String id = _collectionReference.doc().id;
      await _collectionReference
          .doc(id).set(client.toJson(uid: id));
      return null;
    }catch(e){
      return "Error adding new client";
    }
  }


  Future<List<Client>?> getClients()async {
    try{
        QuerySnapshot querySnapshot = await _collectionReference.get();
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