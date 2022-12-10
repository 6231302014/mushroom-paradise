import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paradise_chat/features/data/remote_data_source/data_source/storage_provider.dart';
import 'package:paradise_chat/features/data/remote_data_source/models/user_model.dart';
import 'package:paradise_chat/features/domain/entities/user_entity.dart';
import 'package:paradise_chat/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:paradise_chat/features/presentation/cubit/user/user_cubit.dart';
import 'package:paradise_chat/features/presentation/widgets/common.dart';
import 'package:paradise_chat/features/presentation/widgets/profile_widget.dart';
import 'package:paradise_chat/features/presentation/widgets/textfield_container.dart';
import 'package:paradise_chat/features/presentation/widgets/theme/style.dart';
import 'package:paradise_chat/main.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  const ProfilePage({Key? key, required this.uid}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _statusController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  // TextEditingController? _numController;

  File? _image;
  String? _profileUrl;
  String? _username;
  String? _phoneNumber;
  final picker = ImagePicker();

  void dispose() {
    _nameController.dispose();
    _statusController.dispose();
    _emailController.dispose();
    // _numController!.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //   _nameController = TextEditingController(text: "");
  //   _statusController = TextEditingController(text: "");
  //   // _emailController = TextEditingController(text: "");
  //   // _numController = TextEditingController(text: "");
  //   super.initState();
  // }

  Future getImage() async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          StorageProviderRemoteDataSource.uploadFile(file: _image!)
              .then((value) {
            print("profileUrl");
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        if (userState is UserLoaded) {
          return _profileWidget(userState.users);
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _profileWidget(List<UserEntity> users) {
    final user = users.firstWhere((user) => user.uid == widget.uid,
        orElse: () => UserModel());
    _nameController.value = TextEditingValue(text: "${user.name}");
    _emailController.value = TextEditingValue(text: "${user.email}");
    _statusController.value = TextEditingValue(text: "${user.status}");

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(10, 207, 131, 1),
        title: Text(
          '${user.name}',
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: color747480,
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    child:
                        profileWidget(imageUrl: user.profileUrl, image: _image),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                'Remove profile photo',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: greenColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 28,
              ),
              Container(
                margin: const EdgeInsets.only(left: 22, right: 22),
                height: 47,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: color747480.withOpacity(.2),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: TextField(
                  controller: _nameController,
                  onChanged: (textData) {
                    _username = textData;
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                    hintText: 'username',
                    hintStyle:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 22, right: 22),
                height: 47,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: color747480.withOpacity(.2),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: AbsorbPointer(
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.mail,
                        color: Colors.grey,
                      ),
                      hintText: 'email',
                      hintStyle:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 22, right: 22),
                height: 47,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: color747480.withOpacity(.2),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: TextField(
                  controller: _statusController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.chat,
                      color: Colors.grey,
                    ),
                    hintText: 'status',
                    hintStyle:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              const Divider(
                thickness: 1,
                endIndent: 15,
                indent: 15,
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  _updateProfile();
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 22, right: 22),
                  alignment: Alignment.center,
                  height: 44,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(10, 207, 131, 1),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const Text(
                    'Update',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                child: Container(
                  margin: const EdgeInsets.only(left: 22, right: 22),
                  alignment: Alignment.center,
                  height: 44,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.red[600],
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: TextButton(
                    onPressed: logoutUser,
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateProfile() {
    BlocProvider.of<UserCubit>(context).getUpdateUser(
      user: UserEntity(
        uid: widget.uid,
        name: _nameController.text,
        status: _statusController.text,
 
      ),
    );

    toast("Profile Updated");
  }
  
  
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<Null> logoutUser() async {
    await FirebaseAuth.instance.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();

    // Navigator.pushNamed(context, PageConst.createNewGroupPage, arguments: uid);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MyApp()),
        (Route<dynamic> route) => false);
  }
}
