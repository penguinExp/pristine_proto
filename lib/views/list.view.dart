import 'package:flutter/material.dart';
import '../echo/echo.dart';

class SimpleListView extends StatefulWidget {
  const SimpleListView({super.key});

  @override
  State<SimpleListView> createState() => _SimpleListViewState();
}

class _SimpleListViewState extends State<SimpleListView> {
  final store = ObjectStore([1, 2]);

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple List"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ObjectStoreBuilder(
              store: store,
              widget: (context, data) {
                return SizedBox(
                  height: 100,
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Text(data[index].toString());
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Add Item"),
              onPressed: () {
                store.update((value) => value..add(3));
                // store
                //     .update((value) => value..add(3))
                //     .update((value) => value..add(4))
                //     .update((value) => value..remove(4));
              },
            ),
          ],
        ),
      ),
    );
  }
}
