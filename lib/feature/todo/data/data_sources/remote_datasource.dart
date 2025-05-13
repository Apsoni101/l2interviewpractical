import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/feature/todo/data/models/todo_model.dart';
import 'package:firebase/feature/todo/domain/entities/todo_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemoteDatasource {
  RemoteDatasource();

  final firestore = FirebaseFirestore.instance;

  Future<void> signinAnonymous()async {
    await FirebaseAuth.instance.signInAnonymously();
  }

  Future<void> addTodo(TodoModel todo) async {
    await firestore.collection('todo').add(todo.toMap());
  }


  Stream<List<TodoModel>> getTodos() {
    return firestore.collection('todo').snapshots().map((snapshot) {
    return  snapshot.docs.map((doc) {
       return TodoModel.fromMap(doc.data());
      }).toList( );
    });
  }
}
