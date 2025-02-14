import 'package:poke_dex/models/result_list_model.dart';

class ResponsePokemon {
  final int count;
  final String? next;
  final String? previous;
  final List<ListPokemon> results;

  ResponsePokemon(
      {required this.next,
      required this.previous,
      required this.results,
      required this.count});

  factory ResponsePokemon.fromMap(Map<String, dynamic> map) {
    return ResponsePokemon(
        next: map["next"] as String?,
        previous: map["previous"] as String?,
        results: (map["results"] as List<dynamic>)
            .map((pokemon) => ListPokemon.toModel(pokemon))
            .toList(),
        count: map["count"] as int);
  }
}
