import 'package:chatapp/service/auth_service.dart';
import 'package:chatapp/view/homepage.dart';
import 'package:chatapp/view/sign_in.dart';
import 'package:chatapp/view/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/themecontroller.dart';
import 'firebase_options.dart';

Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
   MyApp({super.key});
  final ThemeController themeController = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
     getPages: [
       GetPage(name: '/', page: () =>(AuthService.authService.getCurrentUser()==null)?SignIn():Homepage()),
       GetPage(name: '/signup', page: () => SignUp()),
       GetPage(name: '/home', page: () => Homepage( ))
     ],
      
    );
  }
}
