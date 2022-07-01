class Inicio {
  final int offset;

  Inicio({required this.offset});

  Inicio copyWith({int? offset}) => Inicio(offset: offset ?? this.offset);
}
