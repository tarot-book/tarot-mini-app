import 'package:flutter/material.dart';
import 'package:tarot_mini_app/widgets/layout/page_layout.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: PageLayout(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Information about the app goes here.'),
        ),
      ),
    );
  }
}
