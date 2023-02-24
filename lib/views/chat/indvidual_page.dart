import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/model/chat_model.dart';
import 'package:flutter/foundation.dart' as foundation;

class IndividualGroup extends StatefulWidget {
  const IndividualGroup({super.key, required this.chatModel});
  final ChatModel chatModel;

  @override
  State<IndividualGroup> createState() => _IndividualGroupState();
}

class _IndividualGroupState extends State<IndividualGroup> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
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
                style: const TextStyle(fontSize: 11),
              )
            ],
          ),
        ),
        leadingWidth: 80,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.arrow_back),
            CircleAvatar(
              radius: 17,
              backgroundColor: Colors.grey,
              child: Icon(
                widget.chatModel.isGroup == true ? Icons.groups : Icons.person,
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
            ListView(),
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
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Type a message',
                                    contentPadding: const EdgeInsets.all(15),
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
                                        color: Color(0xFF128C7E),
                                      ),
                                    ),
                                    suffixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.attach_file_outlined,
                                            color: Color(0xFF128C7E),
                                          ),
                                          onPressed: () {},
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.camera_alt_rounded,
                                            color: Color(0xFF128C7E),
                                          ),
                                          onPressed: () {},
                                        ),
                                      ],
                                    )),
                              ))),
                      Padding(
                        padding:
                            const EdgeInsets.only(bottom: 8, right: 5, left: 2),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: const Color(0xFF128C7E),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.mic),
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
