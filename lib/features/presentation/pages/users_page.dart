// import 'package:flutter/material.dart';
// import 'package:paradise_chat/features/domain/entities/user_entity.dart';
// import 'package:paradise_chat/features/presentation/widgets/single_item_user_widget%20copy.dart';

// class UsersPage extends StatelessWidget {
//   final List<UserEntity> users;
//   const UsersPage({Key?key,required this.users}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       child: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//                 itemCount: users.length,
//                 itemBuilder: (context, index) {
//                   return SingleItemUserWidget(
//                     profileUser: users[index],
//                     onTap: () {},
//                   );
//                 }),
//           )
//         ],
//       ),
//     );
//   }
// }
