import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/models/todo.dart';
import 'package:http/http.dart';

abstract class Services {
  Future<List<Todo>> getTodos();
  Future<void> updateTodos(int id, bool completed);
}

class FirebaseServices extends Services {
  @override
  Future<List<Todo>> getTodos() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('todos').get();

    AllTodos todos = AllTodos.fromSnapshot(snapshot);
    return todos.todos;
  }

    CollectionReference todos = FirebaseFirestore.instance.collection('todos');
    Future<void> updateTodos(int id, bool completed) async {
      await FirebaseFirestore.instance
        .collection('todos')
        .where('id', isEqualTo: id)
        .get()
        .then((QuerySnapshot querySnapshot) {
        return todos
              .doc(todos.id)
              .update({'completed': completed})
              .then((value) => print("todos updated"))
              .catchError((error) => print("Failed to update todos : $error"));
        });
        
    }
  }


class HttpServices {
  Client client = Client();

  Future<List<Todo>> getTodos() async {
    final response = await client.get(Uri.parse(
      'https://jsonplaceholder.typicode.com/todos',
    ));

    if (response.statusCode == 200) {
      var all = AllTodos.fromJson(
        json.decode(response.body),
      );

      return all.todos;
    }

    throw Exception('Failed to load todos');
  }
}
