// lib/providers/deck_state.dart
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  int? _selectedDeckId;

  int? get selectedDeckId => _selectedDeckId;

  void selectDeck(int id) {
    _selectedDeckId = id;
    notifyListeners();
  }
}
