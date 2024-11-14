import 'package:flutter/material.dart';
import 'createContact.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class TemperatureScreen extends StatefulWidget {
  @override
  _TemperatureScreenState createState() => _TemperatureScreenState();
}

class _TemperatureScreenState extends State<TemperatureScreen> {
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _longController = TextEditingController();
  String _temperature = "Esperando..."; // Para mostrar la temperatura
  bool _isLoading = false;

  // Función para obtener la temperatura desde la API
  Future<void> fetchTemperature() async {
    setState(() {
      _isLoading = true;
      _temperature = "Cargando...";
    });

    try {
      final lat = double.parse(_latController.text);
      final long = double.parse(_longController.text);

      final url = Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$long&current=temperature',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final temp = data['current']
            ['temperature']; // Asumiendo que la respuesta es correcta
        setState(() {
          _temperature = '${temp.toStringAsFixed(1)} °C';
        });
      } else {
        setState(() {
          _temperature = "Error al obtener datos";
        });
      }
    } catch (e) {
      setState(() {
        _temperature = "Error en la conexión, temperatura promedio: 17 °C";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultar Temperatura'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _latController,
              decoration: InputDecoration(labelText: 'Latitud'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            TextField(
              controller: _longController,
              decoration: InputDecoration(labelText: 'Longitud'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : fetchTemperature,
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Obtener Temperatura'),
            ),
            SizedBox(height: 20),
            Text(
              'Temperatura: $_temperature',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Desarrollado por: Milady Lopez & Karolyne Renteria',
              
            ),
          ],
        ),
      ),
    );
  }
}
