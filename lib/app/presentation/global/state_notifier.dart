import 'package:flutter/foundation.dart';

abstract class StateNotifier<T> extends ChangeNotifier {
  StateNotifier(this._state) : _oldState = _state;
  T _state, _oldState;
  bool _mounted = true;

  T get state => _state;
  T get oldState => _oldState;
  bool get mounted => _mounted;

  void _update(
    T newState, {
    bool notify = true,
  }) {
    if (_state == newState) {
      return;
    }
    _oldState = _state;
    _state = newState;
    if (notify) {
      notifyListeners();
    }
  }

  set state(T newState) {
    _update(newState);
  }

  void onlyUpdate(T newState) {
    _update(newState, notify: false);
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}
