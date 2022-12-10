import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paradise_chat/const.dart';
import 'package:paradise_chat/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:paradise_chat/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:paradise_chat/features/presentation/pages/group_chat_page.dart';
import 'package:paradise_chat/features/presentation/pages/detection_offline.dart';
import 'package:paradise_chat/features/presentation/widgets/common.dart';
import 'package:paradise_chat/features/presentation/widgets/theme/style.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isShowPassword = true;
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      body: BlocConsumer<CredentialCubit, CredentialState>(
        listener: (context, credentialState) {
          if (credentialState is CredentialSuccess) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }
          if (credentialState is CredentialFailure) {
            snackBarNetwork(
                msg: "wrong email please check", scaffoldState: _scaffoldState);
          }
        },
        builder: (context, credentialState) {
          if (credentialState is CredentialLoading) {
            return Scaffold(
              body: loadingIndicatorProgressBar(),
            );
          }
          if (credentialState is CredentialSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return HomePage(
                    uid: authState.uid,
                  );
                } else {
                  // print("Unauthenticsted");
                  return _bodyWidget();
                }
              },
            );
          }

          return _bodyWidget();
        },
      ),
    );
  }

  _bodyWidget() {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        alignment: Alignment.center,
        child: Stack(
          children: [
            Positioned(
              top: -40,
              right: -150,
              child: Image.asset(
                'assets/mushroom.jpeg',
              ),
            ),
            Positioned(
              top: -60,
              left: 0,
              child: Image.asset(
                'assets/mushroom1.jpeg',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    child: Container(
                      // padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 32),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 100,
                          ),
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'M',
                                  style: TextStyle(
                                    fontSize: 45,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromRGBO(10, 207, 131, 1),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  'USHROOM PARADISE',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromRGBO(10, 207, 131, 1)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 250,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 1),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.2),
                                    offset: const Offset(10.0, 10.0),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                  ),
                                ],
                              ),
                              child:
                                  Image.asset('assets/Logo Fungi paradise.png'),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Divider(
                              thickness: 1,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  BlocProvider.of<CredentialCubit>(context)
                                      .googleAuthSubmit();
                                },
                                child: Container(
                                  width: 270,
                                  height: 65,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                    image:
                                        AssetImage("assets/Google_SignIn.png"),
                                    fit: BoxFit.cover,
                                  )),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            // margin: EdgeInsets.only(right: 25),
                            height: size.height * 0.1,
                            width: size.width * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 5,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              backgroundColor: Color.fromRGBO(10, 207, 131, 1),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CameraScreen2()));
                                },
                                icon: Icon(Icons.camera_alt),
                                iconSize: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitLogin() {
    if (_emailController.text.isEmpty) {
      toast('enter your email');
      return;
    }
    if (_passwordController.text.isEmpty) {
      toast('enter your password');
      return;
    }
    BlocProvider.of<CredentialCubit>(context).signInSubmit(
      email: _emailController.text,
      password: _passwordController.text,
    );
  }
}
