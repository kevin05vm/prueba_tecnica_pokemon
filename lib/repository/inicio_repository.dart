import 'package:http/http.dart' as http;

import 'package:prueba_tecnica_pokemon/models/pokemon.dart';
import 'package:prueba_tecnica_pokemon/models/pokemon_detalle.dart';

class InicioRepository {
  final String _baseUrl = "https://pokeapi.co/api/v2/pokemon";

  Future<Pokemon> getPokemons(int offset) async {
    if (offset > 125) return Pokemon(results: []);
    final response =
        await http.get(Uri.parse('$_baseUrl?limit=25&offset=$offset'));
    if (response.statusCode == 200) {
      final pokemons = pokemonFromMap(response.body);
      for (var pokemon in pokemons.results) {
        final pokemonDetalle = await getPokemonDetalle(pokemon.url);
        pokemon.pokemonDetalle = pokemonDetalle;
      }
      return pokemons;
    } else {
      throw Exception("Error al consultar lista");
    }
  }

  Future<PokemonDetalle> getPokemonDetalle(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return pokemonDetalleFromMap(response.body);
    } else {
      throw Exception("Error al consultar detalle");
    }
  }
}
