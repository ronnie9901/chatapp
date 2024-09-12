
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{


  TextEditingController txtemail =TextEditingController();
  TextEditingController txtpassword =TextEditingController();
  TextEditingController txtconpassword =TextEditingController();
  TextEditingController txtname = TextEditingController();
  TextEditingController txtimg = TextEditingController();
  TextEditingController txtPhone =TextEditingController();


  bool chack = false;
  var icon = Icons.remove_red_eye;


  void chck(bool  check){
    check= !chack;
    if(chack){
      icon = Icons.visibility_off;
    }
    else{
      icon = Icons.remove_red_eye;
    }
  }
  var items = ['Option 1', 'Option 2', 'Option 3'];
  var selectedItem = ''.obs;
  void updateSelectedItem(String? value) {
    selectedItem.value = value ?? '';
  }

}
