import 'package:equatable/equatable.dart';
import 'package:firebase/feature/todo/domain/entities/todo_entity.dart';
import 'package:firebase/feature/todo/domain/use_cases/todo_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoUsecase todoUsecase;

  TodoBloc(this.todoUsecase) : super(TodoInitial()) {
    on<AddTodoEvent>(_addTodoEvent);
    on<LoadTodos>(_loadTodosEvent);
    on<UpdatedTodos>(_updatedTodos);
  }

  Future<void> _addTodoEvent(
      AddTodoEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      await todoUsecase.addTodo(event.todoEntity);
      add(LoadTodos());
    } catch (e) {
      emit(TodoAddedFailure());
    }
  }

  Future<void> _loadTodosEvent(
      LoadTodos event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      todoUsecase.getListTodo().listen((todos) {
        add(UpdatedTodos(todos));
      });
    } catch (e) {
      emit(TodoError());
    }
  }

  Future<void> _updatedTodos(
      UpdatedTodos event, Emitter<TodoState> emit) async {
     emit(TodoLoaded(event.todos));
  }
}
