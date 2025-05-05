import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_with_api/providers/TodoProvider.dart';
import 'package:todo_with_api/screens/screen_2.dart';

import '../models/todo_model.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  bool comp = false;
  @override
  Widget build(BuildContext context) {
    print("Fetching todo");
    context.read<TodoProvider>().fetchTodo();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        title: Text("Todo Appplication With API"),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, providerContext, child) {
          List<Todo> todos = providerContext.getTodo();
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Checkbox(
                  value: todos[index].isCompleted,
                  onChanged: (value) {
                    comp = value!;
                    setState(() {
                      context.read<TodoProvider>().updateisCompleted(
                        completed: value,
                        id: todos[index].id,
                      );
                    });
                  },
                ),
                title: Text(todos[index].title),
                subtitle: Text(todos[index].description),
                trailing: IconButton(
                  onPressed: () {
                    context.read<TodoProvider>().deleteTodo(
                      id: todos[index].id,
                    );
                    providerContext.fetchTodo();
                  },
                  icon: Icon(Icons.delete_outline),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => Screen2()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
