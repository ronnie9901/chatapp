
import 'package:chatapp/model/userModel.dart';
import 'package:chatapp/service/cloud_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth{

  GoogleAuth._();
  static GoogleAuth googleAuth =GoogleAuth._();

  GoogleSignIn googleSignIn =GoogleSignIn();

   FirebaseAuth  auth = FirebaseAuth.instance;
  Future  signInGoogle() async {

   try{
     GoogleSignInAccount? account = await googleSignIn.signIn();
     GoogleSignInAuthentication authentication =  await account!.authentication;

     AuthCredential authCredential =  GoogleAuthProvider.credential(accessToken: authentication.accessToken,idToken: authentication.idToken);
     UserCredential userCredential =  await  FirebaseAuth.instance.signInWithCredential(authCredential);

     final User? user =  userCredential.user;

      Map userModal ={
        'name': user!.displayName,
        'email': user.email,
        'phone': user.phoneNumber,
        'img': user.photoURL,
        'token': '',
      };

     UserModel user1 = UserModel.fromMap(userModal);
     CloudFirestoreService.cloudFirestoreService.insertUser(user1);

  }catch(e){
     'faild';
   }
   }
}