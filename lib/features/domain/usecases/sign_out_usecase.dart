import 'package:paradise_chat/features/domain/entities/user_entity.dart';
import 'package:paradise_chat/features/domain/repositories/firebase_repository.dart';

class SignOutUseCase {
  final FirebaseRepository repository;
  SignOutUseCase({required this.repository});

  Future<void> signOut() {
    return repository.signOut();
  }
}
