import 'package:paradise_chat/features/domain/repositories/firebase_repository.dart';

class GetCurrentUIDUseCase {
  final FirebaseRepository repository;

  GetCurrentUIDUseCase({required this.repository});
  Future<String> call() {
    return repository.getCurrentUId();
  }
}
