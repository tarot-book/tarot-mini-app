// lib/providers/deck_state.dart
import 'package:flutter/material.dart';
import 'package:tarot_mini_app/models/deck.dart';
import 'package:tarot_mini_app/models/source.dart';

class AppState extends ChangeNotifier {
  Deck? _selectedDeck;
  Source? _selectedSource;

  Deck? get selectedDeck => _selectedDeck;
  Source? get selectedSource => _selectedSource;

  void selectDeck(Deck deck) {
    _selectedDeck = deck;
    notifyListeners();
  }

  void selectSource(Source source) {
    _selectedSource = source;
    notifyListeners();
  }
}
