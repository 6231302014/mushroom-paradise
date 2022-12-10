import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paradise_chat/features/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    String name = "username",
    String email = "",
    bool isOnline= false,
    String uid= "",
    String status = "",
    String profileUrl = "",

  }) : super(
          name: name,
          email: email,
   
          isOnline: isOnline,
          uid: uid,
          status: status,
          profileUrl: profileUrl,
        );



  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      name: snapshot.get('name'),
      email: snapshot.get('email'),
      isOnline: snapshot.get('isOnline'),
      uid: snapshot.get('uid'),
      status: snapshot.get('status'),
      profileUrl: snapshot.get('profileUrl'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "name": name,
      "email": email,
      "isOnline": isOnline,
      "uid": uid,
      "status": status,
      "profileUrl": profileUrl,

    };
  }
}