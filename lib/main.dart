import 'package:flutter/material.dart';

import 'package:http/http.dart' as http; //permite que façamos as requisições
import 'package:async/async.dart';
import 'dart:convert';

Uri request = Uri.https("api.hgbrasil.com", "finance?format=json&key=aae5991f");

void main() async {
  http.Response response = await http.get(request);
  print(json.decode(response.body)["results"]["currencies"]["USD"]);

  runApp(MaterialApp(
    home: Container(),
  ));
}
