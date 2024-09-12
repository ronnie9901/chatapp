import 'package:chatapp/model/userModel.dart';
import 'package:chatapp/service/cloud_service.dart';
import 'package:chatapp/view/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../service/auth_service.dart';
class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller.txtname,
              style: TextStyle(fontSize: 15),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: (Icon(Icons.person)),

                  label: Text('UserName'),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.black,
                      ))),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: controller.txtemail,
              style: TextStyle(fontSize: 15),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: (Icon(CupertinoIcons.person)),

                  label: Text('email'),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.black,
                      ))),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: controller.txtpassword,
              style: TextStyle(fontSize: 15),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: (Icon(Icons.lock)),
                  suffixIcon: IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.eye)),
                  label: Text('password'),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.black,
                      ))),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: controller.txtconpassword,
              style: TextStyle(fontSize: 15),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: (Icon(Icons.lock)),
                  suffixIcon: IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.eye)),
                  label: Text('Comfirm Passawaed'),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.black,
                      ))),
            ),
            TextButton(
                onPressed: () {
                  Get.toNamed('/');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('                       already you gave  Account ?'),
                    Text(
                      '  Sign-In',
                      style: TextStyle(color: Colors.blue),
                    )
                  ],
                )),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () async {
                 if(controller.txtpassword.text == controller.txtconpassword.text){

                   await AuthService.authService.creatUser(controller.txtemail.text, controller.txtpassword.text);
                   UserModel user =UserModel( controller.txtname.text,controller.txtemail.text,'','','');

                   CloudFirestoreService.cloudFirestoreService.insertUser(user);
                   Get.back();

                   controller.txtpassword.clear();
                   controller.txtemail.clear();
                   controller.txtPhone.clear();
                 }



              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  'Sign-Up ',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),

          ],
        ),
      ),
    );
  }
}
