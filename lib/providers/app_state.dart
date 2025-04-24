// lib/providers/deck_state.dart
import 'package:flutter/material.dart';
import 'package:tarot_mini_app/models/deck.dart';

class AppState extends ChangeNotifier {
  Deck? _selectedDeck;

  Deck? get selectedDeck => _selectedDeck;

  void selectDeck(Deck deck) {
    _selectedDeck = deck;
    notifyListeners();
  }
}
