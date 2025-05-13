import 'package:firebase/feature/todo/data/data_sources/remote_datasource.dart';
import 'package:firebase/feature/todo/data/models/todo_model.dart';
import 'package:firebase/feature/todo/domain/entities/todo_entity.dart';

import '../../domain/repositories/repo.dart';

class RepoImpl implements Repo {
  RemoteDatasource remoteDatasource;

  RepoImpl(this.remoteDatasource);


  @override
  Future<void> addTodo(TodoEntity todo) async {
    await remoteDatasource.addTodo(
      TodoModel(
        id: todo.id,
        title: todo.title,
        description: todo.description,
        timestamp: todo.timestamp,
      ),
    );
  }

  @override
  Stream<List<TodoEntity>> getListTodo() {
   return remoteDatasource.getTodos();

  }

  @override
  Future<void> signinAnonymously() async{
    await remoteDatasource.signinAnonymous();
  }
}
