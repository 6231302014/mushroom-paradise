import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paradise_chat/features/data/remote_data_source/data_source/storage_provider.dart';
import 'package:paradise_chat/features/domain/entities/group_entity.dart';
import 'package:paradise_chat/features/presentation/cubit/group/group_cubit.dart';
import 'package:paradise_chat/features/presentation/widgets/common.dart';
import 'package:paradise_chat/features/presentation/widgets/profile_widget.dart';
import 'package:paradise_chat/features/presentation/widgets/textfield_container.dart';
import 'package:paradise_chat/features/presentation/widgets/theme/style.dart';

class CreateGroupPage extends StatefulWidget {
  final String uid;

  const CreateGroupPage({Key? key, required this.uid}) : super(key: key);
  @override
  _CreateGroupPageState createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  TextEditingController _groupNameController = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  File? _image;
  String? _profileUrl;
  final picker = ImagePicker();

  Future getImage() async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);

          StorageProviderRemoteDataSource.uploadFile(file: _image!)
              .then((value) {
            print(_image);
            setState(() {
              _profileUrl = value;
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

  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(10, 207, 131, 1),
        title: const Text("Create group"),
      ),
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    _image == null
                        ? CircleAvatar(
                            child: Image.asset('assets/profile_default.png'),
                            radius: 64,
                          )
                        : CircleAvatar(
                            backgroundImage: FileImage(
                              _image!,
                            ),
                            radius: 64,
                          ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: getImage,
                        icon: const Icon(
                          Icons.add_a_photo,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 17,
                ),
                TextFieldContainer(
                  controller: _groupNameController,
                  keyboardType: TextInputType.text,
                  hintText: 'Group name',
                  prefixIcon: Icons.person,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  thickness: 2,
                  indent: 120,
                  endIndent: 120,
                ),
                const SizedBox(
                  height: 17,
                ),
                InkWell(
                  onTap: () {
                    _submit();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 44,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color.fromRGBO(10, 207, 131, 1),
                    ),
                    child: const Text(
                      'Create New Group',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'By clicking Create New Group, you agree to the ',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: colorC1C1C1),
                      ),
                      Text(
                        'Privacy Policy',
                        style: TextStyle(
                            color: greenColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'and ',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: colorC1C1C1),
                      ),
                      Text(
                        'terms ',
                        style: TextStyle(
                            color: greenColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        'of use',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: colorC1C1C1),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _submit() async {
    if (_image == null) {
      toast('Please Add profile image');
      return;
    }
    if (_groupNameController.text.isEmpty) {
      toast('Enter your group name');
      return;
    }

    BlocProvider.of<GroupCubit>(context).getCreateGroup(
        groupEntity: GroupEntity(
      lastMessage: "",
      uid: widget.uid,
      groupName: _groupNameController.text,
      creationTime: Timestamp.now(),
      groupProfileImage: _profileUrl!,
      joinUsers: "0",
    ));
    toast("${_groupNameController.text} created successfully");
    _clear();
    Navigator.pop(context);
  }

  void _clear() {
    setState(() {
      _groupNameController.clear();
      _profileUrl = "";
      _image = null;
    });
  }
}
