import 'package:flutter/material.dart';
import 'createContact.dart';
import 'temperatureScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consulta de Temperatura',
      // Definir las rutas
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) =>
            TemperatureScreen(), // Pantalla principal
        '/createcontact': (BuildContext context) =>
            CreateContact(), // Otra pantalla (de ejemplo)
      },
    );
  }
}
