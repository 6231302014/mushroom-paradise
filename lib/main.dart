import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paradise_chat/const.dart';
import 'package:paradise_chat/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:paradise_chat/features/presentation/cubit/chat/chat_cubit.dart';
import 'package:paradise_chat/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:paradise_chat/features/presentation/cubit/group/group_cubit.dart';
import 'package:paradise_chat/features/presentation/cubit/user/user_cubit.dart';
import 'package:paradise_chat/features/presentation/pages/group_chat_page.dart';
import 'package:paradise_chat/features/presentation/pages/login_page.dart';
import 'package:paradise_chat/features/presentation/pages/menu_page.dart';
import 'package:paradise_chat/on_generate_route.dart';
import 'package:flutter/material.dart';
import 'package:paradise_chat/on_generate_route.dart';
import 'injection_container.dart' as di;
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => di.sl<AuthCubit>()..appStarted(),
        ),
        BlocProvider<CredentialCubit>(
          create: (_) => di.sl<CredentialCubit>(),
        ),
        BlocProvider<UserCubit>(
          create: (_) => di.sl<UserCubit>(),
        ),
        BlocProvider<GroupCubit>(
          create: (_) => di.sl<GroupCubit>()..getGroups(),
        ),
        BlocProvider<ChatCubit>(
          create: (_) => di.sl<ChatCubit>(),
        ),
      ],
      child: MaterialApp(
        title: AppConst.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        initialRoute: '/',
        onGenerateRoute: OnGenerateRoute.route,
        routes: {
          "/": (context) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return MainPage(uid: authState.uid);
                } else {
                  return LoginPage();
                }
              },
            );
          }
        },
      ),
    );
  }
}
