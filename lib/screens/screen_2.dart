import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/TodoProvider.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  validate_input(value) {}

  String mytitle = "";
  String mydescription = "";

  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo Form"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter any value";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: "Title",
                  label: Text("Title"),
                ),
                onTapOutside: (event) {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                onSaved: (value) {
                  mytitle = value!;
                },
              ),
              TextFormField(
                onSaved: (value) {
                  mydescription = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter any value";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: "Description",
                  label: Text("Description"),
                ),
                onTapOutside: (event) {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilledButton.tonal(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Icon(Icons.close), Text("Close")],
                    ),
                  ),
                  FilledButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      _formKey.currentState!.save();
                      context.read<TodoProvider>().addTodo(
                        thisTitle: mytitle,
                        thisDescription: mydescription,
                      );
                      context.read<TodoProvider>().fetchTodo();
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Icon(Icons.save_alt), Text("Save")],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
