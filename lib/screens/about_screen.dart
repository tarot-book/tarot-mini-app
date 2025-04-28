import 'package:flutter/material.dart';
import 'package:tarot_mini_app/constants/app_constants.dart';
import 'package:tarot_mini_app/widgets/layout/page_layout.dart';
import 'package:tarot_mini_app/widgets/utils/markdown_section.dart';

const aboutText = '''
# Добро пожаловать в Азбуку Таро!

Она поможет вам изучать **традиционное Таро** и быстро находить интерпретации карт из разных источников.

Выбрав на главной странице колоду, вы сможете изучить значение любой карты в прямой и перевернутой позиции.

Эта программа посвящается памяти [Евгения Николаевича Колесова](https://ru.wikipedia.org/wiki/%D0%9A%D0%BE%D0%BB%D0%B5%D1%81%D0%BE%D0%B2,_%D0%95%D0%B2%D0%B3%D0%B5%D0%BD%D0%B8%D0%B9_%D0%9D%D0%B8%D0%BA%D0%BE%D0%BB%D0%B0%D0%B5%D0%B2%D0%B8%D1%87) (1951–2017), литератора и эзотерика, известного под псевдонимом _Het Monster_.
Тексты были подготовлены им в 1999 году для учебной программы, выпускавшейся на CD-диске.

---

Версия: **${AppConstants.appVersion}**

## В следующих версиях

Будут добавлены:

- Новые колоды
- Интерпретации комбинаций для каждой карты
- Возможно, также расклады и демонстрация гаданий.

---
© 2025 Сергей Крушинский (@ilbagatto). Все права защищены. 

''';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('О программе')),
      body: SingleChildScrollView( // ✅ Нужно обязательно
        child: PageLayout(
          child: MarkdownSection(data: aboutText),
        ),
      ),
    );
  }
}
