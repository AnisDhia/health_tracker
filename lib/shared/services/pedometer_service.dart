import 'dart:developer';

import 'package:pedometer/pedometer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PedometerService {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  // ? steps vars
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?';
  int _todaySteps = 0;

  void onStepCount(StepCount event) {
    log(event.toString());
    // DateTime s = event.timeStamp;
    _todaySteps = event.steps;
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    log(event.toString());
    _status = event.status;
  }

  void onPedestrianStatusError(error) {
    log('onPedestrianStatusError: $error');
    _status = 'Pedestrian Status not available';
    log(_status);
  }

  void onStepCountError(error) {
    log('onStepCountError: $error');
    // _todaySteps = 'Step Count not available';
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
  }
}
