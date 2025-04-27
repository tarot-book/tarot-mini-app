import 'package:flutter/material.dart';
import 'package:tarot_mini_app/models/meaning.dart';

class CardPositionState extends ChangeNotifier {
  CardPosition _position = CardPosition.straight;

  CardPosition get position => _position;

  void setPosition(CardPosition newPosition) {
    if (_position != newPosition) {
      _position = newPosition;
      notifyListeners();
    }
  }
}
