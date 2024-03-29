import 'dart:developer';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/model/chat_model.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:whatsapp_clone/model/message_model.dart';
import 'package:whatsapp_clone/ui/custom_ui/own_message_card.dart';
import 'package:whatsapp_clone/ui/custom_ui/reply_card.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IndividualGroup extends StatefulWidget {
  const IndividualGroup(
      {super.key, required this.chatModel, required this.sourceChat});
  final ChatModel chatModel;
  final ChatModel sourceChat;
  @override
  State<IndividualGroup> createState() => _IndividualGroupState();
}

class _IndividualGroupState extends State<IndividualGroup> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  late IO.Socket socket;
  bool? sendButton;
  List<MessageModel> messages = [];
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
  }

  void connect() {
    socket = IO.io("http://10.4.4.12:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.onConnect(
      (data) {
        print('connected');
        socket.on("message", (msg) {
          log(msg);
          setMessage("destination", msg["message"]);
        });
      },
    );
    socket.emit("signin", widget.sourceChat.id);
    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.onConnectError((err) => print('onCerr ' + err));
    socket.onError((err) => print('err ' + err));
    print(socket.connected);
  }

  void sendMessage(String message, int sourceId, int targetId) {
    setMessage("source", message);
    socket.emit("message",
        {"message": message, "sourceId": sourceId, "targetid": targetId});
  }

  void setMessage(String type, String message) {
    MessageModel messageModel = MessageModel(type: type, message: message);
    setState(() {
      messages.add(messageModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Image.asset(
          'assets/images/whatsapp_chat_background.png',
          height: size.height,
          width: size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: const Color(0xFF075E54),
            title: InkWell(
              onTap: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.chatModel.name.toString(),
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    'last seen today at  ${widget.chatModel.time}',
                    style: const TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
            leadingWidth: 80,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(Icons.arrow_back),
                CircleAvatar(
                  radius: 17,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    widget.chatModel.isGroup == true
                        ? Icons.groups
                        : Icons.person,
                    color: Colors.white,
                  ),
                )
              ]),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
              PopupMenuButton(
                itemBuilder: (context) {
                  return const [
                    PopupMenuItem(
                      value: 1,
                      child: Text('View Contact'),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: Text('Media,links, and docs '),
                    ),
                    PopupMenuItem(
                      value: 3,
                      child: Text('whatsapp Web'),
                    ),
                    PopupMenuItem(
                      value: 4,
                      child: Text('search'),
                    ),
                    PopupMenuItem(
                      value: 5,
                      child: Text('Mute notification'),
                    ),
                    PopupMenuItem(
                      value: 5,
                      child: Text('Wallpaper'),
                    ),
                  ];
                },
                onSelected: (value) => print(value),
              )
            ],
          ),
          body: Container(
            height: size.height,
            width: size.width,
            child: WillPopScope(
              onWillPop: () {
                if (show) {
                  setState(() {
                    show = false;
                  });
                } else
                  (Navigator.pop(context));
                return Future.value(false);
              },
              child: Stack(children: [
                Container(
                  height: size.height - 140,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      if (messages[index].type == "source") {
                        return OwnMessageCard();
                      } else {
                        return ReplyCard();
                      }
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Container(
                              width: size.width - 60,
                              child: Card(
                                  margin: const EdgeInsets.only(
                                      left: 2, right: 2, bottom: 8),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  child: TextFormField(
                                    controller: controller,
                                    focusNode: focusNode,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    minLines: 1,
                                    onChanged: (value) {
                                      if (value.length > 0) {
                                        setState(() {
                                          sendButton = true;
                                        });
                                      } else {
                                        setState(() {
                                          sendButton = false;
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Type a message',
                                        contentPadding:
                                            const EdgeInsets.all(15),
                                        prefixIcon: IconButton(
                                          onPressed: () {
                                            focusNode.unfocus();
                                            focusNode.canRequestFocus = false;
                                            setState(() {
                                              show = !show;
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.emoji_emotions_outlined,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        suffixIcon: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: const Icon(
                                                Icons.attach_file_outlined,
                                                color: Colors.grey,
                                              ),
                                              onPressed: () {
                                                showModalBottomSheet(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder: (context) =>
                                                      bottomSheet(),
                                                );
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.camera_alt_rounded,
                                                color: Colors.grey,
                                              ),
                                              onPressed: () {},
                                            ),
                                          ],
                                        )),
                                  ))),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8, right: 5, left: 2),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: const Color(0xFF128C7E),
                              child: IconButton(
                                onPressed: () {
                                  if (sendButton == true) {
                                    sendMessage(
                                        controller.text,
                                        widget.sourceChat.id!,
                                        widget.chatModel.id!);
                                    controller.clear();
                                  }
                                },
                                icon: Icon(
                                  sendButton == true ? Icons.send : Icons.mic,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      show == true ? emojiSelect() : SizedBox()
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    iconcreation(
                        color: Colors.indigo,
                        icon: Icons.insert_drive_file,
                        text: 'Document'),
                    const SizedBox(
                      width: 40,
                    ),
                    iconcreation(
                        color: Colors.pink,
                        icon: Icons.camera_alt,
                        text: 'Camera'),
                    const SizedBox(
                      width: 40,
                    ),
                    iconcreation(
                        color: Colors.purple,
                        icon: Icons.insert_photo,
                        text: 'Gallery'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    iconcreation(
                        color: Colors.orange,
                        icon: Icons.headphones,
                        text: 'Audio'),
                    const SizedBox(
                      width: 40,
                    ),
                    iconcreation(
                        color: Colors.green,
                        icon: Icons.location_pin,
                        text: 'Location'),
                    const SizedBox(
                      width: 40,
                    ),
                    iconcreation(
                        color: Colors.blue,
                        icon: Icons.person,
                        text: 'Contact'),
                  ],
                ),
              ]),
        ),
      ),
    );
  }

  Widget iconcreation(
      {required IconData icon, required Color color, required String text}) {
    return InkWell(
      onTap: () {
        log('clicked');
      },
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 30,
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }

  Widget emojiSelect() {
    return SizedBox(
      height: 250,
      child: EmojiPicker(
        onEmojiSelected: (category, emoji) {
          setState(() {
            controller.text = controller.text + emoji.emoji;
          });
        },
        config: Config(
          columns: 7,
          emojiSizeMax: 32 *
              (foundation.defaultTargetPlatform == TargetPlatform.iOS
                  ? 1.30
                  : 1.0),
          verticalSpacing: 0,
          horizontalSpacing: 0,
          gridPadding: EdgeInsets.zero,
          initCategory: Category.RECENT,
          bgColor: const Color(0xFFF2F2F2),
          indicatorColor: Colors.blue,
          iconColor: Colors.grey,
          iconColorSelected: Colors.blue,
          backspaceColor: Colors.blue,
          skinToneDialogBgColor: Colors.white,
          skinToneIndicatorColor: Colors.grey,
          enableSkinTones: true,
          showRecentsTab: true,
          recentsLimit: 28,
          replaceEmojiOnLimitExceed: false,
          noRecents: const Text(
            'No Recents',
            style: TextStyle(fontSize: 20, color: Colors.black26),
            textAlign: TextAlign.center,
          ),
          loadingIndicator: const SizedBox.shrink(),
          tabIndicatorAnimDuration: kTabScrollDuration,
          categoryIcons: const CategoryIcons(),
          buttonMode: ButtonMode.MATERIAL,
          checkPlatformCompatibility: true,
        ),
      ),
    );
  }
}
