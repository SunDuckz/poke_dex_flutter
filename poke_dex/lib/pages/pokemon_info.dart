import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:poke_dex/models/info_pokemon.dart';
import 'package:poke_dex/models/result_list_model.dart';

class PokemonInfo extends StatelessWidget {
  final ListPokemon result;
  const PokemonInfo({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(result.name)),
      body: _buildPokeInfoBody(),
    );
  }

  Future<InfoPokemon> _getInfoPokemon() async {
    final dio = Dio();
    final response = await dio.get(result.url);
    var model = InfoPokemon.toMap(response.data);
    await Future.delayed(Duration(seconds: 4));
    return model;
  }

  Widget _buildPokeInfoBody() {
    return FutureBuilder(
        future: _getInfoPokemon(),
        builder: (context, response) {
          var lista = response.data;

          if (response.connectionState == ConnectionState.done) {
            if (lista == null) {
              return Text("nenhum pokemon encontrado");
            }

            var alturaEmCentimetros = lista.height * 10;
            var pesoEmQuilos = lista.weight / 10;
            return Center(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(color: Colors.redAccent),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 15),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey
                                                .withValues(alpha: 0.7),
                                            spreadRadius: 2,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        color: const Color.fromARGB(
                                            76, 158, 158, 158),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: Image.network(
                                      lista.sprites['front_default'] ?? '',
                                      height: 100,
                                      width: 100,
                                      scale: 0.5,
                                    ),
                                  ),
                                  Column(children: [
                                    Text('Name: ${lista.name}',
                                        style: TextStyle(
                                            fontSize: 27,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 10),
                                    Text('Height: $alturaEmCentimetros cm',
                                        style: TextStyle(fontSize: 20)),
                                    Text('Weight: $pesoEmQuilos Kg',
                                        style: TextStyle(fontSize: 20)),
                                  ])
                                ]),
                          ),
                          Text('Types: ',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (var type in lista.types)
                                Text(
                                  '${type.type["name"]} ',
                                  style: TextStyle(fontSize: 25),
                                )
                            ],
                          ),
                          Text('Abilities:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          for (var ability in lista.abilities)
                            Text(ability.ability['name'],
                                style: TextStyle(fontSize: 25))
                        ]),
                  )),
            );
          }

          return CircularProgressIndicator();
        });
  }
}
