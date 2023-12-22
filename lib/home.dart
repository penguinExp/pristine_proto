import 'package:flutter/material.dart';
import 'views/list.view.dart';
import 'views/list_api.view.dart';
import 'views/slider.view.dart';
import 'views/counter.view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Echo Proto"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: MediaQuery.of(context).size.height * 0.27,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CounterView()),
                );
              },
              child: const Text("Simple Counter"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SliderView()),
                );
              },
              child: const Text("Interdependent Slider"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SimpleListView()),
                );
              },
              child: const Text("ObjectStore + List"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ListApiView()),
                );
              },
              child: const Text("GET Req + ListView"),
            ),
          ],
        ),
      ),
    );
  }
}
