import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class GroupEntity extends Equatable {
  final String groupName;
  final String groupProfileImage;
  final String joinUsers;
  final Timestamp? creationTime;
  final String groupId;
  final String uid;
  final String lastMessage;

 GroupEntity({
    this.groupName="",
    this.groupProfileImage="",
    this.joinUsers="",
    this.creationTime,
    this.groupId="",
    this.uid="",
    this.lastMessage="",
  });

  @override
  // TODO: implement props
  List<Object> get props => [
    groupName,
    groupProfileImage,
    joinUsers,
    uid,
    creationTime!,
    groupId,
    lastMessage,
      ];
}