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
  // final control = TextEditingController();
  String control = '';
  List<String> datosBuscar = [];
  String def = '';
  List<dynamic> datos = [];
  List<dynamic> listaDatos = [];
  List<String> c = [];
  String d = '';

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _cargar();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Laboratorio Diccionario de Datos'),
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
            child: Autocomplete<String>(
              // displayStringForOption: datosBuscar,
              optionsBuilder: (TextEditingValue value) {
                if (value.text.isEmpty) {
                  return const Iterable.empty();
                }
                return datosBuscar.where((element) =>
                    element.toUpperCase().contains(value.text.toUpperCase()));
              },
              onSelected: (String eleccion) {
                control = eleccion;
              },
            ),

            // TextField(
            //   controller: control,
            //   decoration: const InputDecoration(hintText: 'Buscar'),
            // ),
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
    setState(() {
      d = '';
      c = [];
      for (int i = 0; i < listaDatos.length; i++) {
        String dato = listaDatos[i].toString();
        d = dato.replaceAll('[', '').replaceAll(']', '');
        c = d.split(':');
        // if (d.contains(':')) {
        //   datosBuscar.add(d.toUpperCase().replaceAll(':', ''));
        // }
        if (control == c[0]) {
          if (d.contains(':')) {
            int j = i + 1;
            String conc = '';
            String datoC = '';
            while (!listaDatos[j].toString().contains(':') && j != 0) {
              datoC = listaDatos[j].toString();
              conc = conc + datoC.replaceAll('[', '').replaceAll(']', '');
              j++;
              if (j == listaDatos.length) {
                j = 0;
              }
            }
            def = conc;
          }
          // if (datosBuscar[i] == control) {
          //   print(datosBuscar[datosBuscar.length - 1]);
          //   print(datosBuscar.length);
          // }
        }
      }
    });
  }

  _cargar() async {
    datosBuscar = [];
    final rDatos = await rootBundle
        .loadString('assets/data/LaboratorioDiccionario325.txt');
    listaDatos = const CsvToListConverter().convert(rDatos);
    setState(() {
      datos = listaDatos;
      for (int i = 0; i < listaDatos.length; i++) {
        String dato = listaDatos[i].toString();
        d = dato.replaceAll('[', '').replaceAll(']', '');
        // c = d.split(':');
        if (d.contains(':')) {
          datosBuscar.add(d.toUpperCase().replaceAll(':', ''));
        }
      }
      // if (b.last == ':') {
      //     def = dato;
      //   }
      // def = b.length.toString();
    });
    // print(listaDatos);
  }
}
