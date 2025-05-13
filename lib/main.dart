import 'package:firebase/core%20/di/app_injector.dart';
import 'package:firebase/feature/todo/domain/use_cases/todo_usecase.dart';
import 'package:firebase/feature/todo/presentation/manager/todo_bloc.dart';
import 'package:firebase/feature/todo/presentation/pages/todo_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await AppInjector.setUp();
  final todoUsecase = AppInjector.getIt<TodoUsecase>();

  await todoUsecase.signinAnonymous();

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider<TodoBloc>(
        create: (context) => AppInjector.getIt<TodoBloc>(),
        child: TodoPage(),
      ),
    );
  }
}
