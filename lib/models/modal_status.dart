import 'package:flutter/foundation.dart';

class ModalStatus extends ChangeNotifier {
  bool _isModalOpen = false;

  bool get isModalOpen => _isModalOpen;

  set isModalOpen(bool value) {
    _isModalOpen = value;
    notifyListeners();
  }
}
