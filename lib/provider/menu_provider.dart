import 'package:flutter/foundation.dart';

class MenuProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> menu = [];

  void addMenu(Map<String, dynamic> product) {
    menu.add(product);
    notifyListeners();
  }

  void removeMenu(Map<String, dynamic> product) {
    menu.remove(product);
    notifyListeners();
  }

  void clearMenu() {
    menu.clear();
    notifyListeners();
  }
}
