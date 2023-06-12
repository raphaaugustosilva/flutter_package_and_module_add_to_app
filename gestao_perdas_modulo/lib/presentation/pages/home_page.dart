import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestao_perdas_modulo/i18n/strings.g.dart';
import 'package:gestao_perdas_package/presentation/pages/gestao_perda_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MethodChannel _channel = const MethodChannel('FLUTTER_FEAT_TEST_RAPHA_CHANNEL');
  String? paramFromNativeLanguage;
  String? paramFromNative01;
  String? paramFromNative02;
  final TextEditingController _controllerModuleParam01 = TextEditingController();
  final TextEditingController _controllerModuleParam02 = TextEditingController();
  final TextEditingController _controllerModuleParam03 = TextEditingController();

  @override
  void initState() {
    super.initState();
    _channel.setMethodCallHandler(_initializeApp);
  }

  Future<dynamic> _initializeApp(MethodCall call) async {
    switch (call.method) {
      case 'calledFromNative':
        final jsonString = call.arguments;
        final data = jsonDecode(jsonString);
        final paramNativeLanguage = data['paramNativeLanguage'];
        final paramNative01 = data['paramNative01'];
        final paramNative02 = data['paramNative02'];

        paramFromNativeLanguage = paramNativeLanguage;
        paramFromNative01 = paramNative01;
        paramFromNative02 = paramNative02;
        ((paramNativeLanguage ?? "").isEmpty) ? LocaleSettings.useDeviceLocale() : LocaleSettings.setLocaleRaw(paramNativeLanguage);
        setState(() {});
        break;

      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 151, 227, 255),
      appBar: AppBar(
        title: Text(t.appBarTitle),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if ((paramFromNative01 ?? "").isNotEmpty || (paramFromNative02 ?? "").isNotEmpty) Text(t.parametersComeFromNative, style: const TextStyle(fontWeight: FontWeight.bold)),
              if ((paramFromNative01 ?? "").isNotEmpty) Text("    ${t.parameter} ${t.native} 01: ${(paramFromNative01 ?? "")}"),
              if ((paramFromNative02 ?? "").isNotEmpty) Text("    ${t.parameter} ${t.native} 02: ${(paramFromNative02 ?? "")}"),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: ((context) => GestaoPerdaPage(locale: paramFromNativeLanguage))));
                },
                child: Text(t.openPackageButtonText),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.all(20),
                color: Colors.blue,
                child: Column(
                  children: [
                    TextField(
                      controller: _controllerModuleParam01,
                      decoration: InputDecoration(label: Text("${t.parameter} 01")),
                    ),
                    TextField(
                      controller: _controllerModuleParam02,
                      decoration: InputDecoration(label: Text("${t.parameter} 02")),
                    ),
                    TextField(
                      controller: _controllerModuleParam03,
                      decoration: InputDecoration(label: Text("${t.parameter} 03")),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        _channel.invokeMethod("call_from_flutter_module", '{"flutterModuleParam01": "${_controllerModuleParam01.text}", "flutterModuleParam02": "${_controllerModuleParam02.text}","flutterModuleParam03": "${_controllerModuleParam03.text}"}');
                        SystemNavigator.pop();
                      },
                      child: Text(t.sendParametersToNativeButtonText),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
