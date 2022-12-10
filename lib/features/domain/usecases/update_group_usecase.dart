

import 'package:paradise_chat/features/domain/entities/group_entity.dart';
import 'package:paradise_chat/features/domain/repositories/firebase_repository.dart';

class UpdateGroupUseCase{
  final FirebaseRepository repository;

  UpdateGroupUseCase({required this.repository});
  Future<void> call(GroupEntity groupEntity){
    return repository.updateGroup(groupEntity);
  }

}