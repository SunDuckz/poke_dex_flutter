class InfoPokemon {
  final String name;
  final List<String> sprites;
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
        name: map["name"],
        sprites: map["sprites"],
        weight: map["weight"],
        height: map["height"],
        abilities: map["abilities"],
        types: map["types"]);
  }
}
