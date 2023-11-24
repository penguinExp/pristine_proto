import 'package:flutter/material.dart';
import 'package:pristine_proto/temp/builder.temp.dart';
import 'package:pristine_proto/temp/store.temp.dart';

class ListViewTemp extends StatefulWidget {
  const ListViewTemp({super.key});

  @override
  State<ListViewTemp> createState() => _ListViewTempState();
}

class _ListViewTempState extends State<ListViewTemp> {
  final listStore = OneStore([1, 2, 3]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BuilderOS(
              store: listStore,
              widget: (context, data) {
                return Text(data.toString());
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Update List"),
              onPressed: () {
                listStore.update((list) {
                  list.add(4);
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
