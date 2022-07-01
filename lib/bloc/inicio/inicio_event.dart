part of 'inicio_bloc.dart';

@immutable
abstract class InicioEvent {}

class LoadPokemon extends InicioEvent {
  final Pokemon? pokemon;
  final Inicio inicio;
  LoadPokemon(this.pokemon, this.inicio);
}

class ShowSelectTeam extends InicioEvent {
  final bool showSelectTeam;
  ShowSelectTeam(this.showSelectTeam);
}
