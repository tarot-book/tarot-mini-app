import 'package:flutter/material.dart';
import 'package:tarot_mini_app/widgets/layout/page_layout.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: PageLayout(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Settings page will be implemented here.'),
        ),
      ),
    );
  }
}
