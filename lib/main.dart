import 'package:flutter/material.dart';

import 'package:http/http.dart' as http; //permite que façamos as requisições
import 'dart:async';
import 'dart:convert';

Uri request = Uri.https("api.hgbrasil.com", "finance?format=json&key=aae5991f");

void main() async {
  runApp(MaterialApp(
    home: const Home(),
    theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          hintStyle: TextStyle(color: Colors.amber),
        )),
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
  final realController = TextEditingController(); //obter os textos
  final dolarController = TextEditingController(); //obter os textos
  final euroController = TextEditingController(); //obter os textos

  double? dolar;
  double? euro;

  void realChanged(String text) {
    //é chamada quando mudamos o valor do real
  }

  void dolarChanged(String text) {
    //é chamada quando mudamos o valor do dolar
  }

  void euroChanged(String text) {
    //é chamada quando mudamos o valor do euro
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("\$ Conversor \$"),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: FutureBuilder(
            //futuro dos dados, solicita os dados e retorna um futuro
            future: getData(),
            //o que vai mostrar na tela
            builder: (context, snapshot) {
              //ver o estado da conecção
              switch (snapshot.connectionState) {
                case ConnectionState.none: //se não estiver conectado
                case ConnectionState.waiting: //ou esperando uma conexão
                  //retorna o widget centralizado
                  return const Center(
                      child: Text(
                    "Carregando Dados...",
                    style: TextStyle(color: Colors.amber, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ));
                default: //caso contrário
                  //se tem erro
                  if (!snapshot.hasError) {
                    return const Center(
                        child: Text(
                      "Erro ao Carregar Dados :(",
                      style: TextStyle(color: Colors.amber, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ));
                    //senão
                  } else {
                    //valor do dolar e euro capturados do servidor
                    dolar =
                        snapshot.data?["results"]["currencies"]["USD"]["buy"];
                    euro =
                        snapshot.data?["results"]["currencies"]["EUR"]["buy"];
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const Icon(Icons.monetization_on,
                              size: 150.0, color: Colors.amber),
                          buildTextField(
                              "Reais", "R\$", realController, realChanged),
                          const Divider(),
                          buildTextField(
                              "Dólares", "US\$", dolarController, dolarChanged),
                          const Divider(),
                          buildTextField(
                              "Euros", "€", euroController, euroChanged),
                        ],
                      ),
                    );
                  }
              }
            }));
  }
}

Widget buildTextField(
    String label, String prefix, TextEditingController c, Function f) {
  return TextField(
    controller: c,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.amber),
        border: const OutlineInputBorder(),
        prefixText: prefix),
    style: const TextStyle(color: Colors.amber, fontSize: 25.0),
    onChanged: (e) => f,
    keyboardType: TextInputType.number,
  );
}
