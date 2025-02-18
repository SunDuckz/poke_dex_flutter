class PokeTypes {
  final int slot;
  final Map<String, dynamic> type;

  PokeTypes({required this.slot, required this.type});

  factory PokeTypes.toMap(Map<String, dynamic> map) {
    return PokeTypes(slot: map["slot"], type: map["type"]);
  }
}
