import 'dart:async';
import 'dart:io';
import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:paradise_chat/features/data/remote_data_source/models/text_message_model.dart';
import 'package:paradise_chat/features/domain/entities/group_entity.dart';
import 'package:paradise_chat/features/domain/entities/single_chat_entity.dart';
import 'package:paradise_chat/features/domain/entities/text_messsage_entity.dart';
import 'package:paradise_chat/features/domain/usecases/get_messages_usecase.dart';
import 'package:paradise_chat/features/presentation/cubit/chat/chat_cubit.dart';
import 'package:paradise_chat/features/presentation/cubit/group/group_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paradise_chat/features/presentation/widgets/common.dart';
import 'package:paradise_chat/features/data/remote_data_source/data_source/storage_provider.dart';

class SingleChatPage extends StatefulWidget {
  final SingleChatEntity singleChatEntity;

  const SingleChatPage({Key? key, required this.singleChatEntity})
      : super(key: key);

  @override
  _SingleChatPageState createState() => _SingleChatPageState();
}

class _SingleChatPageState extends State<SingleChatPage> {
  String messageContent = "";
  TextEditingController _messageController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  bool _changeKeyboardType = false;
  int _menuIndex = 0;
  File? _image;
  String? _imgUrl;
  final picker = ImagePicker();
  String messageType = "";

  @override
  void initState() {
    _messageController.addListener(() {
      setState(() {});
    });
    BlocProvider.of<ChatCubit>(context)
        .getMessages(channelId: widget.singleChatEntity.groupId);
    //FIXME: call get all messages
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future selectImage() async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          StorageProviderRemoteDataSource.uploadFile(file: _image!)
              .then((value) {
            setState(() {
              _imgUrl = value;
              // print(_imgUrl);
              BlocProvider.of<ChatCubit>(context).sendTextMessage(
                  textMessageEntity: TextMessageEntity(
                      time: Timestamp.now(),
                      senderId: widget.singleChatEntity.uid,
                      content: _imgUrl!,
                      senderName: widget.singleChatEntity.username,
                      type: "IMAGE"),
                  channelId: widget.singleChatEntity.groupId);
              BlocProvider.of<GroupCubit>(context).updateGroup(
                  groupEntity: GroupEntity(
                groupId: widget.singleChatEntity.groupId,
                lastMessage: _messageController.text,
                creationTime: Timestamp.now(),
              ));
            });
          });
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      toast("error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(10, 207, 131, 1),
        title: Text("${widget.singleChatEntity.groupName}"),
      ),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (index, chatState) {
          if (chatState is ChatLoaded) {
            return Column(
              children: [
                _messagesListWidget(chatState),
                _sendMessageTextField(),
              ],
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _sendMessageTextField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(80)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.2),
                      offset: const Offset(0.0, 0.50),
                      spreadRadius: 1,
                      blurRadius: 1,
                    )
                  ]),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.insert_emoticon,
                    color: Colors.grey[500],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 60),
                        child: Scrollbar(
                          child: TextField(
                            style: const TextStyle(fontSize: 14),
                            controller: _messageController,
                            maxLines: null,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Type a message"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.link,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      _messageController.text.isEmpty
                          ? IconButton(
                              onPressed: () => {
                                selectImage(),
                              },
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.grey,
                              ),
                            )
                          : const Icon(Icons.camera_alt),
                    ],
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () {
              if (_messageController.text.isEmpty) {
              } else {
                // print(_messageController.text);
                BlocProvider.of<ChatCubit>(context).sendTextMessage(
                    textMessageEntity: TextMessageEntity(
                        time: Timestamp.now(),
                        senderId: widget.singleChatEntity.uid,
                        content: _messageController.text,
                        senderName: widget.singleChatEntity.username,
                        type: "TEXT"),
                    channelId: widget.singleChatEntity.groupId);
                BlocProvider.of<GroupCubit>(context).updateGroup(
                    groupEntity: GroupEntity(
                  groupId: widget.singleChatEntity.groupId,
                  lastMessage: _messageController.text,
                  creationTime: Timestamp.now(),
                ));
                setState(() {
                  _messageController.clear();
                });
              }
            },
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(10, 207, 131, 1),
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _messagesListWidget(ChatLoaded messages) {
    Timer(Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInQuad,
      );
    });
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: messages.messages.length,
        itemBuilder: (_, index) {
          final message = messages.messages[index];
          if (message.type == "IMAGE") {
            messageType = "IMAGE";
          } else if (message.type == "TEXT") {
            messageType = "TEXT";
          }
          if (message.senderId == widget.singleChatEntity.uid)
            return _messageLayout(
              name: "${message.senderName}",
              alignName: TextAlign.end,
              color: Color.fromRGBO(10, 207, 131, 1),
              time: DateFormat('hh:mm a').format(message.time!.toDate()),
              align: TextAlign.left,
              boxAlign: CrossAxisAlignment.start,
              crossAlign: CrossAxisAlignment.end,
              nip: BubbleNip.rightTop,
              text: message.content,
            );
          else
            return _messageLayout(
              color: Colors.teal,
              name: "${message.senderName}",
              alignName: TextAlign.end,
              time: DateFormat('hh:mm a').format(message.time!.toDate()),
              align: TextAlign.left,
              boxAlign: CrossAxisAlignment.start,
              crossAlign: CrossAxisAlignment.start,
              nip: BubbleNip.leftTop,
              text: message.content,
            );
        },
      ),
    );
  }

  Widget _messageLayout({
    text,
    time,
    color,
    align,
    boxAlign,
    nip,
    crossAlign,
    String? name,
    alignName,
  }) {
    return Column(
      crossAxisAlignment: crossAlign,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.90,
          ),
          child: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(3),
            child: Bubble(
              color: color,
              nip: nip,
              child: Column(
                crossAxisAlignment: crossAlign,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "$name",
                    textAlign: alignName,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  messageType == ("IMAGE")
                      ? CachedNetworkImage(
                          imageUrl: text,
                          // height: 150,
                        )
                      : Text(
                          text,
                          textAlign: align,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                  Text(
                    time,
                    textAlign: align,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(
                        .4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
