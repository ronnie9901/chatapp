import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/google_auth_service.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(CupertinoIcons.back)),
        title: Text('Profile Page'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.more_vert),
          )
        ],
      ),
      body: Column(
        children: [
          Center(
              child: Column(
                children: [
                  CircleAvatar(
                              backgroundImage: NetworkImage(
                    '${GoogleAuth.googleAuth.auth.currentUser?.photoURL}'),
                              radius: 70,
                            ),
                  Text('${GoogleAuth.googleAuth.auth.currentUser!.displayName}',style: TextStyle(fontSize: 30),)
                ],
              ),
          ),
        ],
      ),
    );
  }
}
