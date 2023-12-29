import 'package:flutter/material.dart';
import 'package:flutter_test_message/domain/entity/message.dart';
import 'package:flutter_test_message/domain/service/api_service.dart';

enum ViewModelButtonState {
  diseble,
  enable,
  inProces;
}

class ViewModelState {
  final String name;
  final String email;
  final String message;
  final String responseTitleMessage;
  final bool isProces;
  ViewModelButtonState get buttonState {
    if (isProces) {
      return ViewModelButtonState.inProces;
    } else if (name.isNotEmpty && email.isNotEmpty && message.isNotEmpty) {
      return ViewModelButtonState.enable;
    } else {
      return ViewModelButtonState.diseble;
    }
  }

  ViewModelState(
      {this.name = '',
      this.email = '',
      this.message = '',
      this.responseTitleMessage = '',
      this.isProces = false});

  ViewModelState copyWith(
      {String? name,
      String? email,
      String? message,
      String? responseTitleMessage,
      bool? isProces}) {
    return ViewModelState(
        name: name ?? this.name,
        email: email ?? this.email,
        message: message ?? this.message,
        responseTitleMessage: responseTitleMessage ?? this.responseTitleMessage,
        isProces: isProces ?? this.isProces);
  }
}

class ContactUsWidgetModel extends ChangeNotifier {
  var _state = ViewModelState();
  ViewModelState get state => _state;
  final _apiService = ApiService();

  void changeName(String value) {
    _state = _state.copyWith(name: value);
    notifyListeners();
  }

  void changeEmail(String value) {
    _state = _state.copyWith(email: value);
    notifyListeners();
  }

  void changeMessage(String value) {
    _state = _state.copyWith(message: value);
    notifyListeners();
  }

  bool _isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(em);
  }

  Future<void> onButtonSendMessage() async {
    final name = _state.name;
    final email = _state.email;
    final ms = _state.message;

    if (name.isEmpty || email.isEmpty || ms.isEmpty) return;
    _state = _state.copyWith(responseTitleMessage: '', isProces: true);
    notifyListeners();
    final emailIsValided = _isEmail(email);
    if (!emailIsValided) {
      _state = _state.copyWith(
          responseTitleMessage: 'Invalid email address :(', isProces: false);
      notifyListeners();
    } else {
      final message = Message(name: name, email: email, message: ms);
      try {
        await _apiService.postMessage(message: message);
        _state = _state.copyWith(
            responseTitleMessage: 'Successfully :)', isProces: false);
        notifyListeners();
      } catch (exeption) {
        _state = _state.copyWith(
            responseTitleMessage: 'somting wrong: $exeption :(',
            isProces: false);
        notifyListeners();
      }
    }
  }
}

class ContactUsProvider extends InheritedNotifier {
  final ContactUsWidgetModel model;
  const ContactUsProvider(
      {Key? key, required Widget child, required this.model})
      : super(
          key: key,
          notifier: model,
          child: child,
        );

  static ContactUsProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ContactUsProvider>();
  }

  static ContactUsProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<ContactUsProvider>()
        ?.widget;
    return widget is ContactUsProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(ContactUsProvider oldWidget) {
    return true;
  }
}
