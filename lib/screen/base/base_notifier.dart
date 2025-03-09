import 'package:flutter/material.dart';
import 'package:valbury_test/helper/helper_enum.dart';

abstract class BaseNotifier extends ChangeNotifier {
  String _message = '';

  String get message => _message;

  RequestState _state = RequestState.empty;

  RequestState get state => _state;

  void setMessage(String message) {
    _message = message;
  }

  void setState(RequestState state) {
    _state = state;
  }
}
