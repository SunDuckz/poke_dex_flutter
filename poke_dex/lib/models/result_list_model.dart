class ListPokemon {
  final String name;
  final String url;

  ListPokemon({required this.name, required this.url});

  factory ListPokemon.toModel(dynamic map) {
    return ListPokemon(name: map["name"], url: map["url"]);
  }
}
