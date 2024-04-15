import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/UserModel.dart';
import '../model/Users.dart';

class FirebaseServiceUser {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _userCollection = FirebaseFirestore.instance.collection('users');
  FirebaseAuth get auth => _auth;


  Future<void> registerWithEmailAndPassword(String email, String password, UserModel user) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      await _userCollection.doc(result.user!.uid).set(user.toJson());
    } on FirebaseAuthException catch (e){
      if(e.code == "weak-password"){
        throw "Mot de pass est faible ! doit contenir 6 character";
      }else if(e.code == "email-already-in-use"){
        throw "Email est dejà utiliser";
      }
    } catch (e){
      throw e.toString();
    }
  }

  Future<void> deleteUser(String userId, String password) async {
    try {
      AuthCredential credential = EmailAuthProvider.credential(email: _auth.currentUser!.email!, password: password);
      await _auth.currentUser!.reauthenticateWithCredential(credential);
      await _auth.currentUser?.delete();

      await _userCollection.doc(userId).delete();
    } catch (e) {
      print('Error deleting user: $e');
      throw e;
    }
  }

  Future<void> modifyUserById(String userId, UserModel updatedUser) async {
    try {
      await _userCollection.doc(userId).update(updatedUser.toJson(uid: userId));
    } catch (e) {
      print('Error modifying user: $e');
      throw e;
    }
  }

  Future<Map<String, dynamic>?> getUserInfo(String userId) async {
    try {
      DocumentSnapshot userSnapshot = await _userCollection.doc(userId).get();

      if (userSnapshot.exists) {
        return userSnapshot.data() as Map<String, dynamic>?;
      } else {
        print('Document utilisateur non trouvé');
        return null;
      }
    } catch (e) {
      print('Erreur lors de la récupération des informations de l\'utilisateur : $e');
      return null;
    }
  }

  Future<String?> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "L'utilisateur n'a pas été trouvé.";
      } else if (e.code == 'wrong-password') {
        return "Mot de passe incorrect.";
      } else {
        return "Une erreur s'est produite : ${e.message}";
      }
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Stream<List<UserModel>> getUsers() {
    return _userCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        if(doc["role"] == "admin"){
          return AdminUser(
            id_user: doc.id,
            firstName: doc['firstName'],
            lastName:doc['lastName'],
            phoneNumber:doc['phoneNumber'],
            email: doc['email'],
            photoUrl:doc['photoUrl'],
            role:doc['role'],
            password: doc['password'],
          );
        }else{
          return Users(
            id_user: doc.id,
            firstName: doc['firstName'],
            lastName:doc['lastName'],
            phoneNumber:doc['phoneNumber'],
            email: doc['email'],
            photoUrl:doc['photoUrl'],
            idProjet: doc['idProjet'],
            role:doc['role'],
            password: doc['password'],
          );
        }
      }).toList();
    });
  }

  Future<List<UserModel>> rechercheUserParEmailEtPassword(String email, String password) async {
    try {
      QuerySnapshot querySnapshot = await _userCollection
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();

      List<UserModel> users = querySnapshot.docs.map((doc) {
        if(doc["role"] == "admin"){
          return AdminUser(
            id_user: doc.id,
            firstName: doc['firstName'],
            lastName: doc['lastName'],
            phoneNumber: doc['phoneNumber'],
            email: doc['email'],
            photoUrl: doc['photoUrl'],
            role:doc['role'],
            password: doc['password'],
          );
        }else{
         return Users(
            id_user: doc.id,
            firstName: doc['firstName'],
            lastName: doc['lastName'],
            phoneNumber: doc['phoneNumber'],
            email: doc['email'],
            photoUrl: doc['photoUrl'],
            role:doc['role'],
            password: doc['password'],
            idProjet: doc["id_projet"],
          );
        }
      }).toList();
      return users;
    } catch (e) {
      print('Erreur lors de la recherche d\'utilisateur par email et mot de passe : $e');
      return [];
    }
  }

  Future<void> updatePassword(String userId, String newPassword) async {
    try {
      await _auth.currentUser?.updatePassword(newPassword);

      await _userCollection.doc(userId).update({'password': newPassword});
    } catch (e) {
      print('Error updating password: $e');
      throw e;
    }
  }
  Future<void> reAuthenticateUser(String email,String password) async{
    try{
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    }catch (e){
      throw e.toString();
    }
  }

}