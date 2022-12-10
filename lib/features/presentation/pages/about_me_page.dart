import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Color.fromRGBO(10, 207, 131, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(10, 207, 131, 1),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: size.width,
            height: size.height * 0.2,
            child: Image.asset('assets/ct1.jpeg'),
          ),
          // const Text(
          //   'MEMBER',
          //   style: TextStyle(
          //     color: Color.fromRGBO(10, 207, 131, 1),
          //     fontSize: 35,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          Container(
            height: size.height * 0.15,
            width: size.width * 0.95,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(primary: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      height: size.height * 0.1,
                      width: size.width * 0.2,
                      child: Image.asset('assets/pf2.png')),
                  const SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          '6231302014',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Panuwat Duangkham',
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          '6231302014@lamduan.mfu.ac.th',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: size.height * 0.15,
            width: size.width * 0.95,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(primary: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      height: size.height * 0.1,
                      width: size.width * 0.2,
                      child: Image.asset('assets/pf1.png')),
                  const SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          '6231302022',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Atthapong Chuduang',
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          '6231302022@lamduan.mfu.ac.th',
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: size.height * 0.15,
            width: size.width * 0.95,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(primary: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      height: size.height * 0.1,
                      width: size.width * 0.2,
                      child: Image.asset('assets/pf3.png')),
                  const SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          '6231302023',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Wasitpon Saithanya',
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          '6231302023@lamduan.mfu.ac.th',
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
