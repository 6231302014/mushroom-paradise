import 'package:flutter/material.dart';
import 'package:paradise_chat/features/presentation/pages/about_me_page.dart';
import 'package:paradise_chat/features/presentation/pages/group_chat_page.dart';
import 'package:paradise_chat/features/presentation/pages/profile_page.dart';
import 'package:paradise_chat/features/presentation/pages/detection.dart';
import 'package:paradise_chat/features/presentation/pages/new_search_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:paradise_chat/const.dart';
import 'package:paradise_chat/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:paradise_chat/features/presentation/cubit/group/group_cubit.dart';
import 'package:paradise_chat/features/presentation/cubit/user/user_cubit.dart';
import 'package:paradise_chat/features/presentation/pages/all_user_page.dart';
import 'package:paradise_chat/features/presentation/pages/group_page.dart';
import 'package:paradise_chat/features/presentation/pages/profile_page.dart';
import 'package:paradise_chat/features/presentation/widgets/customTabBar.dart';
import 'package:paradise_chat/features/presentation/widgets/theme/style.dart';
import 'package:paradise_chat/main.dart';

class MainPage extends StatefulWidget {
  final String uid;
  const MainPage({Key? key, required this.uid}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState(uid: uid);
}

class _MainPageState extends State<MainPage> {
  _MainPageState({Key, key, required this.uid});
  final String uid;
  int selectedIndex = 0;
  PageController pageController = PageController();

  void onTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserCubit>(context).getUsers();
    BlocProvider.of<GroupCubit>(context).getGroups();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          Container(
            width: size.width,
            height: size.height,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                    height: size.height * 0.2,
                    width: size.width,
                    alignment: Alignment.bottomCenter,
                    child: Image.asset('assets/bg1.png'),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  child: Column(
                    children: [
                      Container(
                        width: size.width,
                        height: size.height * 0.1,
                        color: const Color.fromRGBO(10, 207, 131, 1),
                      ),
                      Container(
                        height: size.height * 0.2,
                        width: size.width,
                        alignment: Alignment.topCenter,
                        child: Image.asset('assets/bg2.png'),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 66),
                        child: Text(
                          'Welcome to ',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 30,
                            fontFamily: 'Comforta',
                            color: Color.fromRGBO(255, 255, 255, 1),
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(0.0, 4.0),
                                blurRadius: 4,
                                color: Color.fromRGBO(0, 0, 0, 0.25),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Mushroom Paradise',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 35,
                            fontFamily: 'Comforta',
                            color: Color.fromRGBO(10, 207, 131, 1),
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(0.0, 4.0),
                                blurRadius: 4,
                                color: Color.fromRGBO(0, 0, 0, 0.25),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: size.height * 0.2,
                              width: size.width * 0.35,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CameraScreen(
                                        uid: uid,
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    primary:
                                        const Color.fromRGBO(86, 204, 242, 1)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.camera_alt,
                                      size: 80,
                                    ),
                                    const Text(
                                      'SCAN',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: size.height * 0.2,
                              width: size.width * 0.35,
                              decoration: BoxDecoration(
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
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HomePage(uid: uid)));
                                },
                                style: ElevatedButton.styleFrom(
                                    primary:
                                        const Color.fromRGBO(111, 207, 151, 1)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.chat,
                                      size: 80,
                                    ),
                                    const Text(
                                      'CHAT',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: size.height * 0.2,
                              width: size.width * 0.35,
                              decoration: BoxDecoration(
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
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProfilePage(uid: widget.uid),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    primary:
                                        const Color.fromRGBO(242, 201, 76, 1)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.person_pin,
                                      size: 80,
                                    ),
                                    Text(
                                      'PROFILE',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: size.height * 0.2,
                              width: size.width * 0.35,
                              decoration: BoxDecoration(
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
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ContactUs(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    primary:
                                        const Color.fromRGBO(235, 87, 87, 1)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.contact_mail,
                                      size: 80,
                                    ),
                                    Text(
                                      'ABOUT ME',
                                      style: TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SearchUser(uid: uid),
          CameraScreen(
            uid: uid,
          ),
          HomePage(uid: uid),
          ProfilePage(uid: widget.uid),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: const IconThemeData(
          color: Color.fromRGBO(10, 207, 131, 1),
        ),
        selectedItemColor: const Color.fromRGBO(10, 207, 131, 1),
        unselectedIconTheme: const IconThemeData(
          color: Colors.black,
        ),
        unselectedItemColor: Colors.white,
        elevation: 0,
        backgroundColor: Colors.white,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: 'Home',
            backgroundColor: Colors.white,
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.search_outlined,
            ),
            label: 'Search',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Container(
              height: 40,
              width: 80,
              padding: const EdgeInsets.fromLTRB(4, 8, 8, 8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [
                    0.1,
                    0.6,
                  ],
                  colors: [
                    Color.fromRGBO(0, 255, 194, 1),
                    Color.fromRGBO(10, 207, 131, 1)
                  ],
                ),
                borderRadius: BorderRadius.circular(50),
                color: Colors.orange,
              ),
              child: const Icon(
                Icons.camera_alt_rounded,
                color: Colors.white,
              ),
            ),
            label: '',
            backgroundColor: Colors.black,
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_outlined,
            ),
            label: 'Chat',
            backgroundColor: Colors.white,
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
            ),
            label: 'Profile',
            backgroundColor: Colors.white,
          ),
        ],
        currentIndex: selectedIndex,
        onTap: onTapped,
      ),
    );
  }
}
