
import 'package:firebase/feature/todo/domain/entities/todo_entity.dart';

abstract class Repo{
  Future<void> addTodo(TodoEntity todo);
  Future<void> signinAnonymously();
  Stream<List<TodoEntity>> getListTodo();
 }