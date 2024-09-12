
import 'package:chatapp/view/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/walpapercontroller.dart';


final WallpaperController wallpaperController = Get.put(WallpaperController());
class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('${controller.txtimg.value}'), // Replace with actual user image URL
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Username',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),), // Replace with dynamic username
                Text('online', style: TextStyle(fontSize: 12, color: Colors.black)),
              ],
            )
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.video_call), onPressed: () {}),
          IconButton(icon: Icon(Icons.call), onPressed: () {}),
          PopupMenuButton<String>(
            color: Colors.blueAccent.shade100,
            onSelected: (value) async {
              if (value == 'Walpaper') {
                await wallpaperController.selectWallpaper(); // Use the controller to select wallpaper
              }
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
                  value: 'view-Contacts',
                  child: Row(
                    children: [
                      Icon(Icons.person, color: Colors.black),
                      SizedBox(width: 10),
                      Text('view-contacts'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'Walpaper',
                  child: Row(
                    children: [
                      Icon(Icons.group, color: Colors.black),
                      SizedBox(width: 10),
                      Text('Walpaper'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'more',
                  child: Row(
                    children: [
                      Icon(Icons.drafts, color: Colors.black),
                      SizedBox(width: 10),
                      Text('more '),
                    ],
                  ),
                ),
              ];
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
        backgroundColor: Colors.blueAccent.shade100,
      ),
      body: Obx(() {
        // Observe changes in wallpaperController.fileImage
        return Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
            image: (wallpaperController.fileImage.value != null)
                ? DecorationImage(
              opacity: 0.7,
              fit: BoxFit.cover,
              image: FileImage(wallpaperController.fileImage.value!),
            )
                : null,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 660),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.grey.shade200)),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        IconButton(icon: Icon(Icons.emoji_emotions), onPressed: () {}),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Type a message",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(icon: Icon(Icons.attach_file), onPressed: () {}),
                        IconButton(icon: Icon(Icons.camera_alt_outlined), onPressed: () {}),
                        IconButton(icon: Icon(Icons.send, color: Colors.blueAccent), onPressed: () {}),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
