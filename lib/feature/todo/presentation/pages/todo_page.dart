import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase/feature/todo/domain/entities/todo_entity.dart';

import '../manager/todo_bloc.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController titlecontroller = TextEditingController();
  final TextEditingController descriptioncontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(LoadTodos());
  }


  @override
  void dispose() {
    super.dispose();
    titlecontroller.dispose();

    descriptioncontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                if (state is TodoLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TodoLoaded) {
                  final todos = state.todos;
                  return ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      return ListTile(title: Text(todo.title),
                      subtitle: Text(todo.description),);
                    },
                  );
                } else if (state is TodoAddedFailure) {
                  return const Center(child: Text('Failed to add todo'));
                } else {
                  return const Center(child: Text('No data'));
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller:titlecontroller ,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      hintText: 'Enter todo title',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: descriptioncontroller,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      hintText: 'Enter todo description',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        context.read<TodoBloc>().add(
                          AddTodoEvent(
                            TodoEntity(
                              id: DateTime.now().toString(),
                              title: titlecontroller.text,
                              description: descriptioncontroller.text,
                              timestamp: DateTime.now().toIso8601String(),
                            ),
                          ),
                        );
                        titlecontroller.clear();
                        descriptioncontroller.clear();
                      }
                    },
                    child: const Text('Add Todo'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
