library gestao_perdas_package.presentation;

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gestao_perdas_package/i18n/strings.g.dart';

class GestaoPerdaPage extends StatefulWidget {
  final String? locale;
  const GestaoPerdaPage({super.key, this.locale});

  @override
  State<GestaoPerdaPage> createState() => _GestaoPerdaPageState();
}

class _GestaoPerdaPageState extends State<GestaoPerdaPage> {
  bool isLoading = false;
  String get apiUrl => "http://demo9554014.mockable.io/poc_flutter_module_${widget.locale}/test";
  String? apiResult;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ((widget.locale ?? "").isEmpty) ? LocaleSettings.useDeviceLocale() : LocaleSettings.setLocaleRaw(widget.locale!);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 151, 227, 255),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("PACKAGE FLUTTER Perdas"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(t.hello),
              Text(t.key_poc),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: ElevatedButton(
                    onPressed: () async {
                      try {
                        isLoading = true;
                        apiResult = null;
                        setState(() {});

                        Dio dio = Dio();
                        await Future.delayed(const Duration(seconds: 2));
                        var response = await dio.get(apiUrl);
                        Map<String, dynamic> responseMap = jsonDecode(jsonEncode(response.data));
                        apiResult = responseMap["result"];
                      } catch (_) {
                      } finally {
                        isLoading = false;
                      }

                      setState(() {});
                    },
                    child: Text(t.buttonGetDataText)),
              ),
              Text(apiUrl, style: const TextStyle(fontSize: 10, color: Colors.red)),
              if (isLoading)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [const SizedBox(height: 30), const CircularProgressIndicator(), const SizedBox(height: 8), Text(t.loadingData, textAlign: TextAlign.center)],
                ),
              if ((apiResult ?? "").isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    children: [
                      Text(t.result, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(apiResult!, textAlign: TextAlign.center),
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
