class PokeSprites {
  final String frontDefault;

  PokeSprites({required this.frontDefault});

  factory PokeSprites.toMap(Map<String, dynamic> map) {
    return PokeSprites(frontDefault: map["front_default"]);
  }
}
