import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:prueba_tecnica_pokemon/models/inicio.dart';

import 'package:prueba_tecnica_pokemon/models/pokemon.dart';
import 'package:prueba_tecnica_pokemon/repository/inicio_repository.dart';

part 'inicio_event.dart';
part 'inicio_state.dart';

class InicioBloc extends Bloc<InicioEvent, InicioState> {
  final _inicioRepository = InicioRepository();

  InicioBloc() : super(InicioInitialState()) {
    on<LoadPokemon>((event, emit) async {
      try {
        final pokemons =
            (event.pokemon != null) ? event.pokemon! : Pokemon(results: []);
        final pokemonsTemp =
            await _inicioRepository.getPokemons(event.inicio.offset);
        pokemons.results.addAll(pokemonsTemp.results);
        emit(InicioSetState(
            pokemons,
            false,
            state.inicio!.copyWith(offset: event.inicio.offset + 25),
            (pokemons.results.length == 150) ? false : true));
      } catch (e) {
        //
      }
    });

    on<ShowSelectTeam>((event, emit) {
      if (!state.existData) return;
      emit(InicioSetState(state.pokemon!, event.showSelectTeam,
          state.inicio!.copyWith(offset: state.inicio!.offset), false));
    });
  }
}
