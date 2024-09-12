import 'package:chatapp/service/auth_service.dart';
import 'package:chatapp/view/homepage.dart';
import 'package:chatapp/view/sign_in.dart';
import 'package:chatapp/view/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'firebase_options.dart';

Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
     getPages: [
       GetPage(name: '/', page: () =>(AuthService.authService.getCurrentUser()==null)?SignIn():Homepage()),
       GetPage(name: '/signup', page: () => SignUp()),
       GetPage(name: '/home', page: () => Homepage())
     ],
      
    );
  }
}
