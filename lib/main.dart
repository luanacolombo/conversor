import 'package:flutter/material.dart';

import 'package:http/http.dart' as http; //permite que façamos as requisições
import 'dart:async';
import 'dart:convert';

Uri request = Uri.https("api.hgbrasil.com", "finance?format=json&key=aae5991f");

void main() async {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

//retorna um mapa no futuro
Future<Map> getData() async {
  //http.get(request) retorna um dado futuro, que vai para a response
  http.Response response = await http.get(request);
  //pega o corpo da response de um arquivo json transforma em um mapa
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("\$ Conversor \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
    );
  }
}
