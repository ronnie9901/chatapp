import 'dart:ui';

import 'package:chatapp/service/auth_service.dart';
import 'package:chatapp/service/google_auth_service.dart';
import 'package:chatapp/view/profilepage.dart';
import 'package:chatapp/view/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import 'detailsScreen.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
          child: Drawer(
            width: 300,
            backgroundColor: Colors.black,
            child: ListView(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Center(child: CircleAvatar(backgroundImage: NetworkImage('${GoogleAuth.googleAuth.auth.currentUser?.photoURL}') ,radius: 50,)),
                  ListTile(
                    title: Text(
                      '    ${GoogleAuth.googleAuth.auth.currentUser!.email}',
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.all_inbox,
                      color: Colors.white,
                      size: 25,
                    ),
                    title: Text(
                      'All Inboxes',
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Container(
                    width: 310,
                    decoration: const BoxDecoration(
                        color: Color(0xFF31303A),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30))),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const ListTile(
                      leading: Icon(
                        Icons.inbox,
                        color: Colors.white,
                        size: 25,
                      ),
                      title: Text(
                        'Inbox',
                        style: TextStyle(fontSize: 18, color: Colors.white70),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
          
                  const ListTile(
                    leading: Icon(
                      Icons.label_important_outline,
                      color: Colors.white,
                      size: 25,
                    ),
                    title: Text(
                      'Important',
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                  ),
          
          
                  const ListTile(
                    leading: Icon(
                      Icons.report_gmailerrorred,
                      color: Colors.white,
                      size: 25,
                    ),
                    title: Text(
                      'block List',
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                  ),
                  const ListTile(
                    leading: Icon(
                      Icons.delete_sweep_outlined,
                      color: Colors.white,
                      size: 25,
                    ),
                    title: Text(
                      'Trash',
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  const ListTile(
                    leading: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 25,
                    ),
                    title: Text(
                      'Create new',
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  const ListTile(
                    leading: Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 25,
                    ),
                    title: Text(
                      'Settings',
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 25,
                    ),
                    title: InkWell(
                      onTap: () async {
                        await AuthService.authService.signout();
                        User? user = AuthService.authService.getCurrentUser();
                        if (user == null) {
                          Get.offAndToNamed('/');
                        }
                      },
                      child: const Text(
                        'Logout',
                        style: TextStyle(fontSize: 18, color: Colors.white70),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('home page'),
        actions: [
          IconButton(
              onPressed: () async {
                
                await AuthService.authService.signout();
                User? user = AuthService.authService.getCurrentUser();
                if (user == null) {
                  Get.offAndToNamed('/');
                }
              },
              icon: Icon(Icons.logout)),
          PopupMenuButton<String>(
            onSelected: (value) {
              // Handle the selection action
              print('Selected: $value');
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'Unread',
                  child: Row(
                    children: [
                      Icon(Icons.markunread, color: Colors.black),
                      SizedBox(width: 10),
                      Text('Unread'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'Contacts',
                  child: Row(
                    children: [
                      Icon(Icons.contacts, color: Colors.black),
                      SizedBox(width: 10),
                      Text('Contacts'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'Non-Contacts',
                  child: Row(
                    children: [
                      Icon(Icons.person_off, color: Colors.black),
                      SizedBox(width: 10),
                      Text('Non-contacts'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'Groups',
                  child: Row(
                    children: [
                      Icon(Icons.group, color: Colors.black),
                      SizedBox(width: 10),
                      Text('Groups'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'Drafts',
                  child: Row(
                    children: [
                      Icon(Icons.drafts, color: Colors.black),
                      SizedBox(width: 10),
                      Text('Drafts'),
                    ],
                  ),
                ),
              ];
            },
            icon: Icon(Icons.more_vert), // Customize the icon if needed
          ),
        ],
      ),
      body: ListView.builder(
      itemCount: 1,
        itemBuilder: (context, index) {

          return  ListTile(
            leading: GestureDetector(
              onTap: () async {
               Navigator.of(context).push(MaterialPageRoute(builder: (context) => Profilepage(),));
              },
              child: CircleAvatar(
                backgroundImage:
                   NetworkImage('${GoogleAuth.googleAuth.auth.currentUser?.photoURL}'),
                radius: 25,
              ),
            ),
            title: Text(
              '${GoogleAuth.googleAuth.auth.currentUser?.displayName}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('hiii'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('12:00', style: TextStyle(color: Colors.grey)),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blueAccent,
                    ),
                    child: Text(
                    '1',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatDetailScreen()),
              );
            },
          );
        },
      ),
    );
  }
}

int selectindex  =0;




