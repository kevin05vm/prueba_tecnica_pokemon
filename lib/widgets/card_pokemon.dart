import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:prueba_tecnica_pokemon/bloc/inicio/inicio_bloc.dart';
import 'package:prueba_tecnica_pokemon/models/pokemon.dart';
import 'package:prueba_tecnica_pokemon/screens/inicio_screen.dart';
import 'package:prueba_tecnica_pokemon/utils/color_pokemon_util.dart';

class CardPokemon extends StatelessWidget {
  final Result result;
  final bool showSelectTeam;

  const CardPokemon(
      {Key? key, required this.result, required this.showSelectTeam})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var estilo1 = const TextStyle(
        fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold);
    var estilo2 = const TextStyle(fontSize: 12.0, color: Colors.white);
    return Card(
        clipBehavior: Clip.antiAlias,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        color: colorPokemon(result.pokemonDetalle!.types.first.type.name),
        child: Stack(clipBehavior: Clip.antiAlias, children: [
          const Positioned(
              top: 60.0,
              right: -5.0,
              child: Image(
                  width: 110.0, image: AssetImage('assets/pokeball.png'))),
          Positioned(
              top: 5.0,
              right: -20.0,
              child: Hero(
                tag: result.pokemonDetalle!.id,
                child: Image(
                  image:
                      NetworkImage(result.pokemonDetalle!.sprites.frontDefault),
                  width: 150.0,
                ),
              )),
          Positioned(
              top: 24,
              left: 14,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${result.name} #${result.pokemonDetalle!.id}',
                        style: estilo1),
                    ...result.pokemonDetalle!.types.map((type) => Container(
                        margin: const EdgeInsets.only(top: 8.0),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6.0, horizontal: 14.0),
                            child: Text(type.type.name, style: estilo2))))
                  ])),
          if (showSelectTeam)
            Positioned(
                top: 4.0,
                right: 4.0,
                child: GestureDetector(
                    child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child:
                            Icon((result.addTeam!) ? Icons.check : Icons.add)),
                    onTap: () {
                      if (!result.addTeam!) {
                        if (InicioScreen.listTeam.length == 6) return;
                        InicioScreen.listTeam.add(result);
                        result.addTeam = true;
                      } else {
                        InicioScreen.listTeam.remove(result);
                        result.addTeam = false;
                      }
                      BlocProvider.of<InicioBloc>(context, listen: false)
                          .add(ShowSelectTeam(true));
                    }))
        ]));
  }
}
