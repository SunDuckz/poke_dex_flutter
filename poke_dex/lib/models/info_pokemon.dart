import 'package:poke_dex/models/poke_abilities.dart';
import 'package:poke_dex/models/poke_types.dart';

class InfoPokemon {
  final String name;
  final Map<String, dynamic> sprites;
  final int weight;
  final List<dynamic> abilities;
  final int height;
  final List<dynamic> types;

  InfoPokemon(
      {required this.name,
      required this.sprites,
      required this.weight,
      required this.height,
      required this.abilities,
      required this.types});

  factory InfoPokemon.toMap(Map<String, dynamic> map) {
    return InfoPokemon(
      name: map["name"] as String,
      sprites: map["sprites"] as Map<String, dynamic>,
      weight: map["weight"] as int,
      height: map["height"] as int,
      abilities: (map["abilities"] as List<dynamic>)
          .map((ability) => PokeAbilities.toMap(ability))
          .toList(),
      types: (map["types"] as List<dynamic>)
          .map((pokemon) => PokeTypes.toMap(pokemon))
          .toList(),
    );
  }
}
