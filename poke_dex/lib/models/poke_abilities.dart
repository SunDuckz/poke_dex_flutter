class PokeAbilities {
  final Map<String, dynamic> ability;
  final bool isHidden;
  final int slot;

  PokeAbilities(
      {required this.ability, required this.isHidden, required this.slot});

  factory PokeAbilities.toMap(Map<String, dynamic> map) {
    return PokeAbilities(
        ability: map["ability"] as Map<String, dynamic>,
        isHidden: map["is_hidden"] as bool,
        slot: map["slot"] as int);
  }
}
