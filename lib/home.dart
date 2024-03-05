import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _ControlarDados = TextEditingController();
  String _Dados = "Resposta";

  _Calcular() async {
    String insertDados = _ControlarDados.text;
    var url = Uri.parse('https://viacep.com.br/ws/${insertDados}/json/');
    http.Response response = await http.get(url);
    Map<String, dynamic> dados = json.decode(response.body);
    String logradouro = dados['logradouro'];
    String cep = dados['cep'];
    String localidade = dados['localidade'];

    setState(() {
      _Dados =
          "Responsta Logradouro: ${logradouro}  Cep: ${cep} Localidade: ${localidade}";
    });

    print(
        "Responsta Logradouro: ${logradouro}  Cep: ${cep} Localidade: ${localidade}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "REQUISIÇÕES EM FLUTTER",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(32)),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Digite o Cp.Ex:01101000"),
              style: TextStyle(color: Colors.blue),
              controller: _ControlarDados,
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            ElevatedButton(onPressed: _Calcular, child: Text("ENCONTRAR")),
            Padding(padding: EdgeInsets.only(top: 20)),
            Text(_Dados)
          ],
        ),
      ),
    );
  }
}
