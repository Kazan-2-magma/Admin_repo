import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/attachement.dart';

class FirebaseServiceAttach{
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference _collectionReference = FirebaseFirestore.instance.collection("attachment");

  Future<void> addAttachment(String projectID,String clientID)async{
    try{
      String id = _collectionReference.doc().id;
      await _collectionReference.doc(id).set(
          Attach(id_client: clientID, id_project: projectID).toJson(uid: id)
      );
    }catch(e){
      print("Attach Error : ${e.toString()}");
    }
  }

  Future<Attach?> getAttachment(String id)async{
    try{
      QuerySnapshot querySnapshot =await _collectionReference
          .where("id",isEqualTo : id)
          .limit(1)
          .get();
      return querySnapshot.docs.map((e){
        return Attach.fromJson(e.data() as Map<String,dynamic>);
      }).first;
    }catch(e){
      return null;
    }
  }
}