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
import 'package:paradise_chat/features/presentation/widgets/customTabBar2.dart';
import 'package:paradise_chat/features/presentation/widgets/theme/style.dart';
import 'package:paradise_chat/main.dart';

class HomePage extends StatefulWidget {
  final String uid;
  const HomePage({Key? key, required this.uid}) : super(key: key);

  @override
  // _HomePageState createState() => _HomePageState();
  State createState() => _HomePageState(uid: uid);
}

class _HomePageState extends State<HomePage> {
  _HomePageState({Key, key, required this.uid});

  TextEditingController _searchTextController = TextEditingController();
  PageController _pageController = PageController(initialPage: 0);
  final String uid;

  List<Widget> get pages => [
        GroupsPage(
          uid: widget.uid,
          query: _searchTextController.text,
        ),
        // AllUsersPage(
        //   uid: widget.uid,
        //   query: _searchTextController.text,
        // ),
        // ProfilePage(uid: widget.uid),
      ];

  int _currentPageIndex = 0;

  bool _isSearch = false;

  @override
  void dispose() {
    _searchTextController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserCubit>(context).getUsers();
    BlocProvider.of<GroupCubit>(context).getGroups();
    _searchTextController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: const Color.fromRGBO(10, 207, 131, 1),
        toolbarHeight: 30,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              CustomTabBarNew(
                index: _currentPageIndex,
                tabClickListener: (index) {
                  _currentPageIndex = index;
                  _pageController.jumpToPage(index);
                },
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPageIndex = index;
                    });
                  },
                  itemCount: pages.length,
                  itemBuilder: (_, index) {
                    return pages[index];
                  },
                ),
              ),
            ],
          ),
          // Positioned(
          //   left: 0,
          //   bottom: 0,
          //   child: Container(
          //     height: size.height * 0.2,
          //     width: size.width,
          //     alignment: Alignment.bottomCenter,
          //     child: Image.asset('assets/bg1.png'),
          //   ),
          // ),
        ],
      ),
    );
  }
}
