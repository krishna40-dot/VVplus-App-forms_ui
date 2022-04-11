import 'package:rxdart/rxdart.dart';

class StepperBloc {
  final _stepController = BehaviorSubject<int>.seeded(0);
  Stream<int> get getStep => _stepController.stream;
  final _isComplete = BehaviorSubject<bool>.seeded(false);
  Stream<bool> get getStatus => _isComplete.stream;
  Sink<bool> get setStatus => _isComplete.sink;

  next(int stepLenght) {
    _stepController.value + 1 != stepLenght
        ? goTo(_stepController.value + 1)
        : _isComplete.add(true);
  }

  goTo(int step) {
    _stepController.add(step);
  }

  cancel() {
    if (_stepController.value > 0) {
      goTo(_stepController.value - 1);
    }
  }

  dispose() {
    _stepController.close();
    _isComplete.close();
  }
}