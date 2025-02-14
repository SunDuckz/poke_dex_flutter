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
    return Placeholder();
  }
}
