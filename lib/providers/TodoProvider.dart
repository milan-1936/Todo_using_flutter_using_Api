import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> _todos = [];

  //   events
  List<Todo> getTodo() {
    return _todos;
  }

  deleteTodo({required int id}) async {
    // event
    final response = await http.delete(
      Uri.parse('http://192.168.100.149:8000/api/todo/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'id': id}),
    );
    print(response.body);
    notifyListeners();
  }

  addTodo({required String thisTitle, required String thisDescription}) async {
    final response = await http.post(
      Uri.parse('http://192.168.100.149:8000/api/todo'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'title': thisTitle, 'description': thisDescription}),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
    } else {
      print("Server error: ${response.statusCode}");
      print("Response: ${response.body}");
    }
  }

  fetchTodo() async {
    final response = await http.get(
      Uri.parse('http://192.168.100.149:8000/api/todo'),
    );
    _todos.clear();
    final data = jsonDecode(response.body) as List;
    data.forEach((d) {
      _todos.add(
        Todo(
          id: d['id'],
          description: d['description'],
          title: d['title'],
          isCompleted: d['completed'] == 1,
        ),
      );
      // print(d);
    });
    // print(_todos);
    notifyListeners();
  }

  updateisCompleted({required bool completed, required int id}) async {
    //event
    final response = await http.put(
      Uri.parse('http://192.168.100.149:8000/api/todo/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },

      body: jsonEncode({'id': id, 'completed': completed}),
    );
    print(jsonDecode(response.body));
    notifyListeners();
  }
}
