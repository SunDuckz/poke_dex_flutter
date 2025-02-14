import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:poke_dex/models/response_pokemon.dart';
import 'package:poke_dex/pages/pokemon_info.dart';

class PokeHomePage extends StatelessWidget {
  const PokeHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Poke Home")),
      body: _buildBody(),
    );
  }

  Future<ResponsePokemon> _getPokemons() async {
    final dio = Dio();
    final response =
        await dio.get('https://pokeapi.co/api/v2/pokemon?offset=0&limit=1304');
    var model = ResponsePokemon.fromMap(response.data);
    await Future.delayed(Duration(seconds: 4));
    return model;
  }

  Widget _buildBody() {
    return FutureBuilder(
        future: _getPokemons(),
        builder: (context, response) {
          var lista = response.data;
          if (response.connectionState == ConnectionState.done) {
            if (lista == null) {
              return Text("nenhum pokemon encontrado");
            }
            return ListView.builder(
                itemCount: lista.results.length,
                itemBuilder: (context, index) {
                  return _buildListTile(lista.results, index, context);
                });
          }

          return CircularProgressIndicator();
        });
  }

  Widget _buildListTile(List results, int index, BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.7),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ]),
        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: ListTile(
            leading: Icon(Icons.catching_pokemon_sharp),
            title: Text(results[index].name),
            subtitle: Text(results[index].url),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PokemonInfo(
                    result: results[index],
                  ),
                ),
              );
            }));
  }
}
