
import 'package:firebase/feature/todo/data/data_sources/remote_datasource.dart';
import 'package:firebase/feature/todo/data/repositories/repo_impl.dart';
import 'package:firebase/feature/todo/domain/repositories/repo.dart';
import 'package:firebase/feature/todo/domain/use_cases/todo_usecase.dart';
import 'package:firebase/feature/todo/presentation/manager/todo_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInjector{
  static final getIt=GetIt.instance;

 static Future<void> setUp() async{
   getIt.registerLazySingleton(()=>RemoteDatasource());
   getIt.registerLazySingleton<Repo>(()=>RepoImpl(getIt<RemoteDatasource>()));
   getIt.registerLazySingleton(()=>TodoUsecase(getIt<Repo>()));
   getIt.registerFactory(()=>TodoBloc(getIt<TodoUsecase>()));



 }
}