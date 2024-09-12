

import 'package:chatapp/model/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class  CloudFirestoreService{

  CloudFirestoreService._();

  static CloudFirestoreService cloudFirestoreService = CloudFirestoreService._();


  FirebaseFirestore fireStore  =  FirebaseFirestore.instance;


  Future<void>  insertUser( UserModel user) async {

      await fireStore.collection("users").doc(user.email).set({
        'name': user.name,
        'email': user.email,
        'phone': user.phone,
        'img': user.img,
        'token': user.token,

      });



  }



}