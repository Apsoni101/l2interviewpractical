part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent extends Equatable{
  const TodoEvent();
  @override
  List<Object?> get props => [];
}
final class AddTodoEvent extends TodoEvent{
  final TodoEntity todoEntity;
  const AddTodoEvent(this.todoEntity);
}
final class LoadTodos extends TodoEvent{

}
final class UpdatedTodos extends TodoEvent{
  final List<TodoEntity> todos;
  UpdatedTodos(this.todos);
}
