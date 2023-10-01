import 'package:flutter/material.dart';

import '../pristine/state_widget.dart';

class SliderView extends StatelessWidget {
  const SliderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Slider"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SliderWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class SliderWidget extends PristineStateWidget<double> {
  SliderWidget({Key? key}) : super(key: key, initialValue: 0);

  @override
  Widget build(BuildContext context, double state) {
    return Column(
      children: [
        Text(state.toString()),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Slider(
            value: state,
            min: 0,
            max: 100,
            divisions: 100,
            onChanged: (val) {
              assign(val);
            },
          ),
        ),
      ],
    );
  }
}
