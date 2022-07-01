import 'dart:convert';

PokemonDetalle pokemonDetalleFromMap(String str) =>
    PokemonDetalle.fromMap(json.decode(str));

String pokemonDetalleToMap(PokemonDetalle data) => json.encode(data.toMap());

class PokemonDetalle {
  final List<Ability> abilities;
  final int height;
  final int id;
  final String name;
  final Sprites sprites;
  final List<Type> types;
  final int weight;

  PokemonDetalle({
    required this.abilities,
    required this.height,
    required this.id,
    required this.name,
    required this.sprites,
    required this.types,
    required this.weight,
  });

  factory PokemonDetalle.fromMap(Map<String, dynamic> json) => PokemonDetalle(
        abilities: List<Ability>.from(
            json["abilities"].map((x) => Ability.fromMap(x))),
        height: json["height"],
        id: json["id"],
        name: json["name"],
        sprites: Sprites.fromMap(json["sprites"]),
        types: List<Type>.from(json["types"].map((x) => Type.fromMap(x))),
        weight: json["weight"],
      );

  Map<String, dynamic> toMap() => {
        "abilities": List<dynamic>.from(abilities.map((x) => x.toMap())),
        "height": height,
        "id": id,
        "name": name,
        "sprites": sprites.toMap(),
        "types": List<dynamic>.from(types.map((x) => x.toMap())),
        "weight": weight,
      };
}

class Ability {
  final AbilityElement ability;

  Ability({required this.ability});

  factory Ability.fromMap(Map<String, dynamic> json) => Ability(
        ability: AbilityElement.fromMap(json["ability"]),
      );

  Map<String, dynamic> toMap() => {"ability": ability.toMap()};
}

class AbilityElement {
  final String name;

  AbilityElement({required this.name});

  factory AbilityElement.fromMap(Map<String, dynamic> json) =>
      AbilityElement(name: json["name"]);

  Map<String, dynamic> toMap() => {"name": name};
}

class Sprites {
  final String frontDefault;

  Sprites({required this.frontDefault});

  factory Sprites.fromMap(Map<String, dynamic> json) =>
      Sprites(frontDefault: json["front_default"]);

  Map<String, dynamic> toMap() => {"front_default": frontDefault};
}

class Type {
  final TypeElement type;

  Type({
    required this.type,
  });

  factory Type.fromMap(Map<String, dynamic> json) => Type(
        type: TypeElement.fromMap(json["type"]),
      );

  Map<String, dynamic> toMap() => {
        "type": type.toMap(),
      };
}

class TypeElement {
  final String name;

  TypeElement({required this.name});

  factory TypeElement.fromMap(Map<String, dynamic> json) =>
      TypeElement(name: json["name"]);

  Map<String, dynamic> toMap() => {"name": name};
}
