import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../echo_old/echo.dart';

class ListApiView extends StatefulWidget {
  const ListApiView({super.key});

  @override
  State<ListApiView> createState() => _ListApiViewState();
}

class _ListApiViewState extends State<ListApiView> {
  final todoStore = ObjectStore([]);

  Future<void> fetchTodo() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/todos"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      todoStore.set(data);
    }
  }

  @override
  void dispose() {
    todoStore.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo's"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ObjectStoreBuilder(
                store: todoStore,
                widget: (context, data) {
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Text(
                        data[index].toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Load Data"),
              onPressed: () async {
                await fetchTodo();
              },
            ),
          ],
        ),
      ),
    );
  }
}
