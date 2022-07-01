import 'dart:convert';

import 'package:prueba_tecnica_pokemon/models/pokemon_detalle.dart';

Pokemon pokemonFromMap(String str) => Pokemon.fromMap(json.decode(str));

String pokemonToMap(Pokemon data) => json.encode(data.toMap());

String listTeamToMap(ListTeam data) => json.encode(data.toMap());

String teamToMap(Team data) => json.encode(data.toMap());

class Pokemon {
  final List<Result> results;

  Pokemon({required this.results});

  factory Pokemon.fromMap(Map<String, dynamic> json) => Pokemon(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
      };
}

class ListTeam {
  ListTeam({
    required this.listTeam,
  });

  List<Team>? listTeam;

  factory ListTeam.fromMap(Map<String, dynamic> json) => ListTeam(
        listTeam: List<Team>.from(json["team"].map((x) => Team.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "team": List<dynamic>.from(listTeam!.map((x) => x.toMap())),
      };
}

class Team {
  final String name;
  final List<Result> teams;
  Team({required this.name, required this.teams});

  factory Team.fromMap(Map<String, dynamic> json) => Team(
        name: json["name"],
        teams: List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "results": List<dynamic>.from(teams.map((x) => x.toMap())),
      };
}

class Result {
  final String name;
  final String url;
  bool? addTeam;
  PokemonDetalle? pokemonDetalle;

  Result(
      {required this.name,
      required this.url,
      this.pokemonDetalle,
      this.addTeam = false});

  factory Result.fromMap(Map<String, dynamic> json) => Result(
      name: json["name"],
      url: json["url"],
      pokemonDetalle: (json.containsKey('pokemonDetalle'))
          ? PokemonDetalle.fromMap(json["pokemonDetalle"])
          : null);

  Map<String, dynamic> toMap() =>
      {"name": name, "url": url, "pokemonDetalle": pokemonDetalle!.toMap()};

  Result copyWith({String? name, String? url, bool? selectTeam}) =>
      Result(name: name ?? this.name, url: url ?? this.url, addTeam: false);
}
