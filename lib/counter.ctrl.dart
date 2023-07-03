import 'pristine/pristine.dart';
import 'pristine/store.dart';

class CounterController extends PristineState {
  @override
  bool get isGlobal => true;

  final counter = ValueStore<int>(0);

  void add() {
    counter.assign(0);
  }
}
