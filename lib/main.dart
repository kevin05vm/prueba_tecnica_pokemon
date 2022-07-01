import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:prueba_tecnica_pokemon/bloc/inicio/inicio_bloc.dart';
import 'package:prueba_tecnica_pokemon/models/inicio.dart';
import 'package:prueba_tecnica_pokemon/router/app_router.dart';
import 'package:prueba_tecnica_pokemon/utils/shared_preferences_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                InicioBloc()..add(LoadPokemon(null, Inicio(offset: 0))))
      ],
      child: MaterialApp(
          title: 'Pokémon App',
          debugShowCheckedModeBanner: false,
          initialRoute: (Preferences.guardarUsuario.isNotEmpty)
              ? AppRoutes.inicioRoute
              : AppRoutes.registroRoute,
          routes: AppRoutes.routes),
    );
  }
}
