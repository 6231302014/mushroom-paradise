import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {

  final String name;
  final String email;
  final bool isOnline;
  final String uid;
  final String status;
  final String profileUrl;
  final String password;


  UserEntity({
    this.name="",
    this.email="",
    this.isOnline = false,
    this.uid="",
    this.status = "Hello there i'm using this app",
    this.profileUrl="",
    this.password="",
  });

  @override
  // TODO: implement props
  List<Object> get props => [
    name,
    email,
    isOnline,
    uid,
    status,
    profileUrl,
    password,

  ];
}