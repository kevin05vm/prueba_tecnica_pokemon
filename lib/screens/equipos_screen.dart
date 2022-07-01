import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:prueba_tecnica_pokemon/utils/shared_preferences_util.dart';
import 'package:prueba_tecnica_pokemon/models/pokemon.dart';
import 'package:prueba_tecnica_pokemon/widgets/card_equipo.dart';

class EquiposScreen extends StatelessWidget {
  const EquiposScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.indigo));
    Map<String, dynamic> map;
    ListTeam equipos = ListTeam(listTeam: []);
    if (Preferences.guardarEquipos.isNotEmpty) {
      map = jsonDecode(Preferences.guardarEquipos);
      equipos.listTeam = ListTeam.fromMap(map).listTeam;
    }
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Mis equipos'),
          backgroundColor: Colors.indigo[300],
        ),
        body: (equipos.listTeam!.isNotEmpty)
            ? ListView.builder(
                itemCount: equipos.listTeam!.length,
                itemBuilder: (context, index) {
                  return CardEquipo(team: equipos.listTeam![index]);
                })
            : Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Image(
                          width: 230.0,
                          height: 230.0,
                          image: AssetImage('assets/charizard.png'),
                          fit: BoxFit.contain),
                      Text('No hay equipos guardados')
                    ]),
              ));
  }
}
