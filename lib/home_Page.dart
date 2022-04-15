import 'package:flutter/material.dart';
import 'dart:async';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final control = TextEditingController();
  String def = '';
  List<List<dynamic>> datos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Autocompletar'),
      ),
      body: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Center(
            child: Text(
              'Henry Quispe Huayta',
              style: TextStyle(fontSize: 30.0),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: TextField(
              controller: control,
              decoration: const InputDecoration(hintText: 'Buscar'),
            ),
          ),
          ElevatedButton(onPressed: _buscar, child: const Text('BUSCAR')),
          Text(
            def,
            style: const TextStyle(fontSize: 20.0),
          ),
        ],
      ),
    );
  }

  _buscar() {
    cargar();
  }
  cargar() async{
    final rDatos = await rootBundle.loadString('assets/data/LaboratorioDiccionario325.txt');
    List<List<dynamic>> listaDatos = const CsvToListConverter().convert(rDatos);
    setState(() {
      datos = listaDatos;
      def = listaDatos[1][0].toString();
    });
  }
}
