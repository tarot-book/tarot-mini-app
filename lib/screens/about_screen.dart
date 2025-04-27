import 'package:flutter/material.dart';
import 'package:tarot_mini_app/widgets/layout/page_layout.dart';
import 'package:tarot_mini_app/widgets/utils/text_section.dart';

const aboutText = '''
Она поможет вам изучать традиционное Таро и быстро находить интерпретации.

Выбрав колоду, в главном меню вы сможете изучить значение любой карты в прямой и перевернутой позиции.

Эта программа посвящается памяти Евгения Николаевича Колесова (1951-2017), литератора и эзотерика, известного под псевдонимом Het Monster. Тексты были подготовлены им в 1999 году для учебной программы, выпускавшейся на CD-диске.

В следующих версиях будут добавлены:

• Новые колоды
• Интерпретации комбинаций для каждой карты
• Возможно, также расклады и демонстрация гаданий.

''';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: PageLayout(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextSection(
            title: 'Добро пожаловать в Азбуку Таро!',
            content: aboutText,
          ),
        ),
      ),
    );
  }
}
