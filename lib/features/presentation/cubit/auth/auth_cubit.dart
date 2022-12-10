import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:paradise_chat/features/domain/usecases/get_current_uid_usecase.dart';
import 'package:paradise_chat/features/domain/usecases/google_sign_in_usecase.dart';
import 'package:paradise_chat/features/domain/usecases/is_sign_in_usecase.dart';
import 'package:paradise_chat/features/domain/usecases/sign_in_usecase.dart';
import 'package:paradise_chat/features/domain/usecases/sign_out_usecase.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IsSignInUseCase isSignInUseCase;
  final SignOutUseCase signOutUseCase;
  final GetCurrentUIDUseCase getCurrentUIDUseCase;
 

  AuthCubit(
      {required this.isSignInUseCase,
      required this.signOutUseCase,
      required this.getCurrentUIDUseCase,
      })
      : super(AuthInitial());

  Future<void> appStarted() async {
    try {
      final isSignIn = await isSignInUseCase.call();

      if (isSignIn) {
        final uid = await getCurrentUIDUseCase.call();
        emit(Authenticated(uid: uid));
      } else {
        emit(UnAuthenticated());
      }
    } on SocketException catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn() async {
    try {
      final uid = await getCurrentUIDUseCase.call();
      // print("user Id $uid");
      emit(Authenticated(uid: uid));
    } catch (_) {
      // print("user Id null");
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedOut() async {
    try {
      await signOutUseCase.signOut();
      emit(UnAuthenticated());
    } catch (_) {
      emit(UnAuthenticated());
    }
  }
}
