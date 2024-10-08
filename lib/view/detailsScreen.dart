import 'package:chatapp/controller/chatController.dart';
import 'package:chatapp/model/chat_model.dart';
import 'package:chatapp/service/auth_service.dart';
import 'package:chatapp/service/cloud_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controller/walpapercontroller.dart';
final WallpaperController wallpaperController = Get.put(WallpaperController());
ChatController chatController = Get.put(ChatController());
class ChatDetailScreen extends StatefulWidget {


  final String? img;

  const ChatDetailScreen({
    Key? key,
    this.img,
  }) : super(
          key: key,
        );

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}


class _ChatDetailScreenState extends State<ChatDetailScreen> {
  @override


  void  initState(){

    super.initState();

    CloudFirestoreService.cloudFirestoreService.updateIsOnline(true);
  }
void dispose(){
    super.dispose();

    CloudFirestoreService.cloudFirestoreService.updateIsOnline(true);

  }
  @
  override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage('${widget.img}'),
                ),
                SizedBox(width: screenWidth * 0.03),
                // Use media query for spacing
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${chatController.receivername}',
                      overflow: TextOverflow.ellipsis,
                      // Adds ellipsis when the text overflows
                      maxLines: 1,
                      // Limits the text to a single line
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    StreamBuilder(
                        stream: CloudFirestoreService.cloudFirestoreService
                            .findUserIsOnline(
                                chatController.receiveremail.value),
                        builder: (context, snapshot) {
                          Map? user = snapshot.data!.data();
                          return Text(
                            user!['isOnline'] ?'isOnline':'Offline',
                            style: TextStyle(
                                fontSize: screenWidth * 0.03,
                                color: Colors.black),
                          );
                        }),
                  ],
                )
              ],
            ),
          ),
          actions: [
            IconButton(icon: Icon(Icons.video_call), onPressed: () {}),
            IconButton(icon: Icon(Icons.call), onPressed: () {}),
            PopupMenuButton<String>(
              color: Colors.blueAccent.shade100,
              onSelected: (value) async {
                if (value == 'Walpaper') {
                  await wallpaperController.selectWallpaper();
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    value: 'Unread',
                    child: Row(
                      children: [
                        Icon(Icons.markunread, color: Colors.black),
                        SizedBox(width: screenWidth * 0.02),
                        Text('Unread'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'view-Contacts',
                    child: Row(
                      children: [
                        Icon(Icons.person, color: Colors.black),
                        SizedBox(width: screenWidth * 0.02),
                        Text('view-contacts'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'Walpaper',
                    child: Row(
                      children: [
                        Icon(Icons.group, color: Colors.black),
                        SizedBox(width: screenWidth * 0.02),
                        Text('Walpaper'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'more',
                    child: Row(
                      children: [
                        Icon(Icons.drafts, color: Colors.black),
                        SizedBox(width: screenWidth * 0.02),
                        Text('more'),
                      ],
                    ),
                  ),
                ];
              },
              icon: Icon(Icons.more_vert),
            ),
          ],
          backgroundColor: Colors.brown.shade200,
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: CloudFirestoreService.cloudFirestoreService
                      .readData(chatController.receiveremail.value),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(snapshot!.error.toString());
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    List data = snapshot.data!.docs;
                    List<chatmodel> chatList = [];
                    List<String> docIdList = [];

                    for (var chat in data) {
                      docIdList.add(chat.id);
                      chatList.add(chatmodel.fromMap(chat.data()));
                    }

                    chatController.getDocIdList(docIdList);

                    return Obx(() => Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          image: (wallpaperController.fileImage.value != null)
                              ? DecorationImage(
                                  opacity: 0.7,
                                  fit: BoxFit.cover,
                                  image: FileImage(
                                      wallpaperController.fileImage.value!),
                                )
                              : null,
                        ),
                        child: ListView.builder(
                            reverse: true,
                            itemCount: chatList.length,
                            itemBuilder: (context, index) {
                              var chat = chatList[index];

                              bool isSender = chatList[index].sender ==
                                  AuthService.authService
                                      .getCurrentUser()!
                                      .email;

                              if (chatList[index].read == false &&
                                  chatList[index].resiever ==
                                      AuthService.authService
                                          .getCurrentUser()!
                                          .email) {
                                CloudFirestoreService.cloudFirestoreService
                                    .updateReadStatus(
                                        chatController.receiveremail.value,
                                    docIdList[index]
                                     );
                              }

                              return GestureDetector(
                                  onLongPress: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('edit'),
                                                  IconButton(
                                                      onPressed: () {
                                                        chatController
                                                            .changeUpdateMessage(
                                                                index);
                                                        chatController
                                                                .txtmessage =
                                                            TextEditingController(
                                                                text: chatList[
                                                                        index]
                                                                    .message);
                                                        Navigator.pop(context);
                                                      },
                                                      icon: Icon(Icons.edit))
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      CloudFirestoreService
                                                          .cloudFirestoreService
                                                          .deleteChat(
                                                        docIdList[index],
                                                        chatController
                                                            .receiveremail
                                                            .value,
                                                      );

                                                      Get.back();
                                                    },
                                                    child: Text('delete'),
                                                  ),
                                                  Icon(Icons.delete),
                                                ],
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('cancel   ')),
                                                Text('save')
                                              ],
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Align(
                                    alignment: isSender
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                      decoration: BoxDecoration(
                                        color: isSender
                                            ? Colors.blue
                                            : Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Column(
                                          crossAxisAlignment: isSender
                                              ? CrossAxisAlignment.end
                                              : CrossAxisAlignment.start,
                                          children: [
                                            Text(chatList[index].message!,
                                                style: TextStyle(
                                                    color: isSender
                                                        ? Colors.white
                                                        : Colors.black)),
                                            SizedBox(height: 4),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    DateFormat('HH:mm').format(
                                                        chatList[index]
                                                            .time!
                                                            .toDate()),
                                                    // Format time to "HH:mm"
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: isSender
                                                          ? Colors.white70
                                                          : Colors.black54,
                                                    ),
                                                  ),
                                                ),
                                                (chatList[index].read && chatList[index].sender == AuthService.authService.getCurrentUser()!.email!)

                                                        ? Icon(
                                                            Icons.done_all,
                                                            color: Colors
                                                                .green.shade700,
                                                            size: 18,
                                                          )
                                                    : Container(),
                                              ],
                                            ),
                                          ]),
                                    ),
                                  ));
                            })));
                  }),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
              decoration: BoxDecoration(color: Colors.grey.shade100
                  // border: Border(top: BorderSide(color: Colors.grey.shade200)),
                  ),
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.emoji_emotions), onPressed: () {}),
                  Expanded(
                    child: TextField(
                      controller: chatController.txtmessage,
                      decoration: InputDecoration(
                        hintText: "Type a message",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(icon: Icon(Icons.attach_file), onPressed: () {}),
                  IconButton(
                      icon: Icon(Icons.camera_alt_outlined),
                      onPressed: () async {}),
                  GetBuilder<ChatController>(
                    builder: (controller) => IconButton(
                        icon: Icon(Icons.send, color: Colors.black),
                        onPressed: () async {
                          if (controller.check.value == false &&
                              controller.txtmessage.text.isNotEmpty) {

                            chatmodel chat = chatmodel(
                                sender: AuthService.authService
                                    .getCurrentUser()!
                                    .email!,
                                resiever: controller.receiveremail.value,
                                message: controller.txtmessage.text,
                                time: Timestamp.now(),
                                read: true);

                            controller.txtmessage.clear();
                            await CloudFirestoreService.cloudFirestoreService
                                .adddData(chat);
                          } else {
                            String dcId =
                                controller.docIdList[controller.docIndex.value];
                            CloudFirestoreService.cloudFirestoreService
                                .updatechat(controller.txtmessage.text,
                                    controller.receiveremail.value, dcId);
                            chatController.txtmessage.clear();
                            controller.setFalseUpdate();
                          }
                        }),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
