import 'package:flutter/material.dart';

import 'package:prueba_tecnica_pokemon/screens/screens.dart';

class AppRoutes {
  static const inicioRoute = 'inicio';
  static const registroRoute = 'registro';
  static const detalleCompromisoRoute = 'detalle';
  static const equipos = 'equipos';

  static Map<String, Widget Function(BuildContext)> routes = {
    inicioRoute: (BuildContext context) => const InicioScreen(),
    registroRoute: (BuildContext context) => const RegistroScreen(),
    detalleCompromisoRoute: (BuildContext context) => const DetalleScreen(),
    equipos: (BuildContext context) => const EquiposScreen()
  };
}
