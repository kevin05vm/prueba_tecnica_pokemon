import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:prueba_tecnica_pokemon/bloc/inicio/inicio_bloc.dart';
import 'package:prueba_tecnica_pokemon/models/pokemon.dart';
import 'package:prueba_tecnica_pokemon/router/app_router.dart';
import 'package:prueba_tecnica_pokemon/utils/shared_preferences_util.dart';
import 'package:prueba_tecnica_pokemon/utils/sliver_delegate_util.dart';
import 'package:prueba_tecnica_pokemon/widgets/card_pokemon.dart';
import 'package:prueba_tecnica_pokemon/widgets/custom_progress_indicator.dart';

class InicioScreen extends StatefulWidget {
  static List<Result> listTeam = [];

  const InicioScreen({Key? key}) : super(key: key);

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  final ScrollController _scrollController = ScrollController();
  bool isDownload = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final inicioBloc = BlocProvider.of<InicioBloc>(context, listen: false);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 400.0 &&
          !isDownload) {
        isDownload = true;
        if (inicioBloc.state.pokemon!.results.length != 150) {
          inicioBloc.add(
              LoadPokemon(inicioBloc.state.pokemon, inicioBloc.state.inicio!));
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var estilo1 = const TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white.withOpacity(0.3)));
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
            slivers: [
              SliverPersistentHeader(
                  floating: true,
                  delegate: SliverCustomHeaderDelegate(
                      minHeight: 150.0,
                      maxHeight: 170.0,
                      child: Stack(
                        children: [
                          Container(
                            color: Colors.white,
                          ),
                          Positioned(
                            top: -100,
                            right: -120,
                            child: Image(
                                width: 350,
                                color: Colors.blueGrey.withOpacity(0.1),
                                image: const AssetImage('assets/pokeball.png')),
                          ),
                          Column(children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 50.0, right: 30.0),
                                child: IconButton(
                                    icon: const Icon(Icons.list),
                                    color: Colors.black,
                                    iconSize: 34.0,
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(AppRoutes.equipos);
                                    }),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text(
                                      'Pokedex (${Preferences.guardarUsuario})',
                                      style: estilo1)),
                            )
                          ]),
                        ],
                      ))),
              SliverList(
                  delegate: SliverChildListDelegate([
                BlocBuilder<InicioBloc, InicioState>(builder: (_, state) {
                  if (state.existData) isDownload = false;
                  return state.existData
                      ? Container(
                          margin: const EdgeInsets.only(bottom: 84.0),
                          child: Column(children: [
                            GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1.4),
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: state.pokemon!.results.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      child: CardPokemon(
                                        result: state.pokemon!.results[index],
                                        showSelectTeam: state.showSelectTeam!,
                                      ),
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            AppRoutes.detalleCompromisoRoute,
                                            arguments:
                                                state.pokemon!.results[index]);
                                      });
                                }),
                            if (state.isLoading)
                              const CustomProgressIndicator(
                                  mensaje: 'Cargando...')
                          ]))
                      : const CustomProgressIndicator(mensaje: 'Espere...');
                })
              ]))
            ]),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            backgroundColor: Colors.indigo[300],
            onPressed: () {
              if (InicioScreen.listTeam.isEmpty) {
                BlocProvider.of<InicioBloc>(context, listen: false)
                    .add(ShowSelectTeam(true));
              } else if (InicioScreen.listTeam.length == 6) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content:
                            DialogTeamWidget(listTeam: InicioScreen.listTeam),
                      );
                    });
              }
            }));
  }
}

class DialogTeamWidget extends StatelessWidget {
  final List<Result> listTeam;

  const DialogTeamWidget({Key? key, required this.listTeam}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var estilo1 = const TextStyle(
        fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold);
    var estilo2 = const TextStyle(color: Colors.black);
    String nombreEquipo = '';
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Guardar equipo', style: estilo1),
          const SizedBox(height: 10.0),
          TextField(
            textCapitalization: TextCapitalization.sentences,
            style: estilo2,
            decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange)),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange)),
                labelText: 'Nombre del equipo',
                labelStyle: estilo2),
            onChanged: (value) => nombreEquipo = value,
          ),
          const SizedBox(height: 50.0),
          Center(
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.orange),
                  ),
                  child: Text('Guardar', style: estilo2),
                  onPressed: () {
                    if (nombreEquipo.trim().isNotEmpty) {
                      Map<String, dynamic> map;
                      ListTeam equipos = ListTeam(listTeam: []);
                      if (Preferences.guardarEquipos.isNotEmpty) {
                        map = jsonDecode(Preferences.guardarEquipos);
                        equipos.listTeam = ListTeam.fromMap(map).listTeam;
                      }
                      equipos.listTeam!
                          .add(Team(teams: listTeam, name: nombreEquipo));
                      Preferences.guardarEquipos = listTeamToMap(equipos);
                      BlocProvider.of<InicioBloc>(context, listen: false)
                          .add(ShowSelectTeam(false));
                      nombreEquipo = '';
                      for (var pokemonItem in listTeam) {
                        final blocInicio =
                            BlocProvider.of<InicioBloc>(context, listen: false);
                        if (blocInicio.state.pokemon!.results
                            .contains(pokemonItem)) {
                          final pokemon = blocInicio.state.pokemon!.results
                              .firstWhere((element) =>
                                  element.name == pokemonItem.name);
                          pokemon.addTeam = false;
                        }
                      }
                      listTeam.clear();
                      Navigator.pop(context);
                    }
                  }))
        ]);
  }
}
