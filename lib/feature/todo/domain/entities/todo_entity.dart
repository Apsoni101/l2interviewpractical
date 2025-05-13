import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  String id;
  String title;
  String description;
  String timestamp;

  TodoEntity({required this.id, required this.title, required this.description, required this.timestamp});

  @override
  List<Object?> get props => [id, title, description, timestamp];
}
