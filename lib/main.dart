import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/semantics.dart'; // Añade esta importación
import 'app/politimetrica_app.dart'; // Corrige el nombre del archivo

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    SemanticsBinding.instance.ensureSemantics();
    runApp(const PolitiMetricaApp()); // Asegúrate que el nombre de la clase sea correcto
  });
}

