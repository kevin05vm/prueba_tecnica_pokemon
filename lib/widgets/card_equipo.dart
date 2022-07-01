import 'package:flutter/material.dart';

import 'package:prueba_tecnica_pokemon/models/pokemon.dart';
import 'package:prueba_tecnica_pokemon/utils/color_pokemon_util.dart';

class CardEquipo extends StatelessWidget {
  final Team team;

  const CardEquipo({Key? key, required this.team}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var estilo1 = const TextStyle(
        fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold);
    return Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        color: Colors.indigo[300],
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(team.name, style: estilo1),
              Container(
                  margin: const EdgeInsets.all(4.0),
                  height: 100.0,
                  child: ListView.builder(
                      itemCount: team.teams.length,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                                backgroundColor: colorPokemon(team.teams[index]
                                    .pokemonDetalle!.types.first.type.name),
                                radius: 40.0,
                                child: Image.network(
                                    team.teams[index].pokemonDetalle!.sprites
                                        .frontDefault,
                                    fit: BoxFit.cover)));
                      }))
            ])));
  }
}
