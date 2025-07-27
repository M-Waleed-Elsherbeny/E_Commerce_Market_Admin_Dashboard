import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    log('onChange Bloc: $bloc, Change: $change');
  }

  @override
  void onClose(BlocBase bloc) {
    log('onClose Bloc: $bloc closed');
  }

  @override
  void onCreate(BlocBase bloc) {
    log('onCreate Bloc: $bloc created');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('onError Bloc: $bloc, Error: $error, StackTrace: $stackTrace');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    log('onEvent Bloc: $bloc, Event: $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log('onTransition Bloc: $bloc, Transition: $transition');
    }
}
