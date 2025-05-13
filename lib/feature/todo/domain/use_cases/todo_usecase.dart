
import '../entities/todo_entity.dart';
import '../repositories/repo.dart';

class TodoUsecase{
  Repo repo;
  TodoUsecase (this.repo);
  Future<void> addTodo(TodoEntity todo) async {
    await repo.addTodo(todo);
  }
  Future<void> signinAnonymous() async {
    await repo.signinAnonymously();
  }
  Stream<List<TodoEntity>> getListTodo(){
    return repo.getListTodo();
  }
}