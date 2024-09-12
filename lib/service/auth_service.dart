import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';


class AuthService {

  AuthService._();
  static AuthService authService= AuthService._();

   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

   Future<String> creatUser( String email,String password) async {

    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return 'success';
    }
    catch(e){

      return e.toString();

    }

   }

   Future<String>  signIn(String email,String password) async {


     try{
       await  _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
       return 'success';
     }
     catch(e){

       return e.toString();

     }

   }

   Future<void> signout() async {

      await _firebaseAuth.signOut();

   }

   User?  getCurrentUser(){
     User? user =_firebaseAuth.currentUser;
     if(user !=null){
        log("email${user.email}");
     }
     return user;
   }


}