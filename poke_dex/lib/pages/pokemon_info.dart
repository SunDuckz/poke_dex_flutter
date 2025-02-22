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
      //backgroundColor: _corDependendoDoTipo(),
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/img.jpg"),
                        fit: BoxFit.fitWidth),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 4),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(209, 255, 255, 255),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(lista.name,
                                style: TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 4),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(209, 255, 255, 255),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                for (var type in lista.types)
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                        color: _corDependendoDoTipo(
                                            type.type["name"])),
                                    child: Text(
                                      type.type["name"],
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        child: Image.network(
                          lista.sprites['front_default'] ?? '',
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.7),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Informações',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold)),
                            Text('Height: $alturaEmCentimetros cm',
                                style: TextStyle(fontSize: 20)),
                            Text('Weight: $pesoEmQuilos Kg',
                                style: TextStyle(fontSize: 20)),
                            Text('Abilities:',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold)),
                            for (var ability in lista.abilities)
                              Text(ability.ability['name'],
                                  style: TextStyle(fontSize: 25))
                          ]),
                    ),
                  ),
                ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}

Color _corDependendoDoTipo(String name) {
  switch (name) {
    case 'grass':
      return const Color.fromARGB(255, 55, 212, 60);
    case 'fire':
      return const Color.fromARGB(255, 240, 73, 7);
    case 'water':
      return Colors.blue.shade100;
    case 'electric':
      return Colors.amber;
    case 'poison':
      return const Color.fromARGB(255, 175, 37, 202);
    case 'bug':
      return const Color.fromARGB(255, 138, 204, 63);
    case 'flying':
      return const Color.fromARGB(255, 129, 199, 231);
    case 'normal':
      return const Color.fromARGB(255, 201, 199, 199);
    case 'fighting':
      return const Color.fromARGB(255, 218, 6, 6);
    case 'rock':
      return const Color.fromARGB(255, 199, 99, 63);
    case 'psychic':
      return Colors.deepPurpleAccent.shade100;
    case 'fairy':
      return const Color.fromARGB(255, 214, 106, 182);
    case 'ghost':
      return const Color.fromARGB(255, 109, 16, 231);
    default:
      return Colors.grey;
  }
}
