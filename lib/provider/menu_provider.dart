import 'package:flutter/foundation.dart';

class MenuProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> menu = [];

  void addMenu(Map<String, dynamic> meal) {
    menu.add(meal);
    notifyListeners();
  }

  void removeMenu(Map<String, dynamic> meal) {
    menu.remove(meal);
    notifyListeners();
  }

  void clearMenu() {
    menu.clear();
    notifyListeners();
  }

  void favorite(Map<String, dynamic> fav) {
    menu.add(fav);
  }
}
