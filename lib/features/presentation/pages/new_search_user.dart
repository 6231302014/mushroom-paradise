import 'package:flutter/material.dart';
import 'package:paradise_chat/const.dart';
import 'package:paradise_chat/features/presentation/pages/all_user_page.dart';
import 'package:paradise_chat/features/presentation/pages/group_page.dart';
import 'package:paradise_chat/features/presentation/pages/group_page_for_search.dart';
import 'package:paradise_chat/features/presentation/pages/profile_page.dart';
import 'package:paradise_chat/features/presentation/widgets/customTabBar.dart';
import 'package:paradise_chat/features/presentation/widgets/theme/style.dart';

class SearchUser extends StatefulWidget {
  final String uid;
  const SearchUser({Key? key, required this.uid}) : super(key: key);

  @override
  State<SearchUser> createState() => _SearchUserState(uid: uid);
}

class _SearchUserState extends State<SearchUser> {
  _SearchUserState({Key, key, required this.uid});

  final String uid;
  bool isSearch = false;
  TextEditingController searchTextController = TextEditingController();
  PageController pageController = PageController();

  List<Widget> get pages => [
        GroupsPageForSearch(
          uid: widget.uid,
          query: searchTextController.text,
        ),
        AllUsersPage(
          uid: widget.uid,
          query: searchTextController.text,
        ),
      ];
  int currentPageIndex = 0;

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    searchTextController.addListener(() {
      setState(() {});
    });
  }

  buildSearchField() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      height: 40,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(.3),
            spreadRadius: 1,
            offset: const Offset(0, 0.50))
      ]),
      child: TextField(
        controller: searchTextController,
        decoration: InputDecoration(
          hintText: "Search...",
          border: InputBorder.none,
          prefixIcon: InkWell(
              onTap: () {
                searchTextController.text = "";
                setState(() {
                  isSearch = false;
                });
              },
              child: const Icon(
                Icons.arrow_back,
                size: 25,
                color: Color.fromRGBO(10, 207, 131, 1),
              )),
          hintStyle: const TextStyle(),
        ),
        style: const TextStyle(fontSize: 16.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: isSearch == false
            ? const Color.fromRGBO(10, 207, 131, 1)
            : const Color.fromRGBO(10, 207, 131, 1),
        title: isSearch == false
            ? const Text(
                "Search",
              )
            : Container(
                height: 0.0,
                width: 0.0,
              ),
        flexibleSpace: isSearch == true
            ? buildSearchField()
            : Container(
                height: 0.0,
                width: 0.0,
              ),
        actions: isSearch == false
            ? [
                InkWell(
                  onTap: () {
                    setState(() {
                      isSearch = true;
                    });
                  },
                  child: const Icon(
                    Icons.search,
                  ),
                ),
                const SizedBox(
                  width: 150,
                ),
              ]
            : [],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              isSearch == false
                  ? CustomTabBar(
                      index: currentPageIndex,
                      tabClickListener: (index) {
                        currentPageIndex = index;
                        pageController.jumpToPage(index);
                      },
                    )
                  : Container(
                      width: 0.0,
                      height: 0.0,
                    ),
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentPageIndex = index;
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
        ],
      ),
    );
  }
}
