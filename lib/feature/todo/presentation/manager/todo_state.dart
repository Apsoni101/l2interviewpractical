part of 'todo_bloc.dart';

@immutable
sealed class TodoState {}

final class TodoInitial extends TodoState {}
final class TodoLoaded extends TodoState {
  List<TodoEntity> todos;
  TodoLoaded(this.todos);
}
final class TodoAddedSuccess extends TodoState {}
final class TodoAddedFailure extends TodoState {}
final class TodoLoading extends TodoState {}
final class TodoError extends TodoState {}
