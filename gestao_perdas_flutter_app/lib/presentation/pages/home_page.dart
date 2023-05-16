import 'package:flutter/material.dart';
import 'package:gestao_perdas_package/i18n/strings.g.dart';
import 'package:gestao_perdas_package/presentation/pages/gestao_perda_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> list = <String>['en', 'es', 'pt'];
  String? dropdownValue;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        dropdownValue = LocaleSettings.useDeviceLocale().languageCode;
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 151, 227, 255),
      appBar: AppBar(
        title: const Text("FLUTTER APP GESTAO PERDAS"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("LINGUAGEM:    "),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_drop_down),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(height: 2, color: Colors.deepPurpleAccent),
                  onChanged: (String? value) => setState(() => dropdownValue = value!),
                  items: list.map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(value: value, child: Text(value))).toList(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: ((context) => GestaoPerdaPage(locale: dropdownValue))));
              },
              child: const Text("ABRIR PACKAGE GESTÃO PERDAS"),
            ),
          ],
        ),
      ),
    );
  }
}
