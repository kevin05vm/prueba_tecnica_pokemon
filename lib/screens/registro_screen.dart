import 'package:flutter/material.dart';

import 'package:prueba_tecnica_pokemon/router/app_router.dart';
import 'package:prueba_tecnica_pokemon/utils/shared_preferences_util.dart';

class RegistroScreen extends StatelessWidget {
  const RegistroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var estilo1 = const TextStyle(fontSize: 24.0, color: Colors.white);
    var estilo2 = const TextStyle(color: Colors.white70);
    String nombre = '';
    return Scaffold(
        backgroundColor: Colors.red,
        body: SafeArea(
            child: Stack(children: [
          Center(
              child: Image(
                  width: 300,
                  color: Colors.white.withOpacity(0.2),
                  image: const AssetImage('assets/pokeball.png'))),
          Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100.0),
                    Text('Registrar', style: estilo1),
                    const SizedBox(height: 50.0),
                    TextField(
                      textCapitalization: TextCapitalization.sentences,
                      style: estilo2,
                      decoration: InputDecoration(
                          enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          labelText: 'Nombre de usuario',
                          labelStyle: estilo2),
                      onChanged: (value) => nombre = value,
                    ),
                    const SizedBox(height: 50.0),
                    Center(
                        child: OutlinedButton(
                            child: Text('Crear Cuenta', style: estilo2),
                            onPressed: () {
                              if (nombre.trim().isNotEmpty) {
                                Preferences.guardarUsuario = nombre;
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    AppRoutes.inicioRoute,
                                    (Route<dynamic> route) => false);
                              }
                            }))
                  ]))
        ])));
  }
}
