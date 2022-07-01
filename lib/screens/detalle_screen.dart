import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:prueba_tecnica_pokemon/models/pokemon.dart';
import 'package:prueba_tecnica_pokemon/utils/color_pokemon_util.dart';

class DetalleScreen extends StatelessWidget {
  const DetalleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pokemon = ModalRoute.of(context)!.settings.arguments as Result;
    var ability = '';
    for (var item in pokemon.pokemonDetalle!.abilities) {
      ability += '${item.ability.name}, ';
    }
    var estilo1 = const TextStyle(
        fontSize: 34.0, fontWeight: FontWeight.bold, color: Colors.white);
    var estilo2 = const TextStyle(fontSize: 12.0, color: Colors.white);
    var estilo3 = const TextStyle(
        fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white);
    var estilo4 = const TextStyle(fontSize: 14.0, color: Colors.black45);
    var estilo5 = const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor:
            colorPokemon(pokemon.pokemonDetalle!.types.first.type.name)));
    return Scaffold(
        backgroundColor:
            colorPokemon(pokemon.pokemonDetalle!.types.first.type.name),
        appBar: AppBar(
          backgroundColor:
              colorPokemon(pokemon.pokemonDetalle!.types.first.type.name),
          elevation: 0.0,
        ),
        body: Stack(children: [
          Positioned(
              top: 170.0,
              right: -20.0,
              child: Hero(
                tag: pokemon.pokemonDetalle!.id,
                child: const Image(
                    width: 220.0,
                    height: 220.0,
                    image: AssetImage('assets/pokeball.png'),
                    fit: BoxFit.contain),
              )),
          Column(children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(pokemon.name, style: estilo1),
                          Text('#${pokemon.pokemonDetalle!.id.toString()}',
                              style: estilo3)
                        ]),
                    ...pokemon.pokemonDetalle!.types.map((type) => Container(
                        margin: const EdgeInsets.only(top: 8.0),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6.0, horizontal: 14.0),
                            child: Text(type.type.name, style: estilo2))))
                  ]),
            ),
            const SizedBox(height: 230.0),
            Expanded(
                child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 8.0),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 14.0),
                        child: Column(children: [
                          const SizedBox(height: 70.0),
                          Row(children: [
                            Text('Height', style: estilo4),
                            const SizedBox(width: 20.0),
                            Text(pokemon.pokemonDetalle!.height.toString(),
                                style: estilo5)
                          ]),
                          const SizedBox(height: 20.0),
                          Row(children: [
                            Text('Weight', style: estilo4),
                            const SizedBox(width: 20.0),
                            Text(
                                '${pokemon.pokemonDetalle!.weight.toString()} kg',
                                style: estilo5)
                          ]),
                          const SizedBox(height: 20.0),
                          Row(children: [
                            Text('Abilities', style: estilo4),
                            const SizedBox(width: 20.0),
                            Text(ability, style: estilo5)
                          ])
                        ]))))
          ]),
          Positioned(
              top: 100.0,
              right: 0.0,
              left: 0.0,
              child: Image(
                  width: 330.0,
                  height: 330.0,
                  image: NetworkImage(
                      pokemon.pokemonDetalle!.sprites.frontDefault),
                  fit: BoxFit.contain))
        ]));
  }
}
