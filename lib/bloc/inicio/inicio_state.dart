part of 'inicio_bloc.dart';

@immutable
abstract class InicioState {
  final bool existData;
  final bool isLoading;
  final Inicio? inicio;
  final Pokemon? pokemon;
  final bool? showSelectTeam;
  final bool? showDialogTeam;

  const InicioState(
      {this.existData = false,
      this.isLoading = false,
      this.inicio,
      this.pokemon,
      this.showSelectTeam = false,
      this.showDialogTeam = false});
}

class InicioInitialState extends InicioState {
  InicioInitialState()
      : super(
            existData: false,
            pokemon: null,
            inicio: Inicio(offset: 0),
            isLoading: false);
}

class InicioSetState extends InicioState {
  final Pokemon newPokemon;
  final bool newShowSelectTeam;
  final Inicio newInicio;
  final bool newIsLoading;
  const InicioSetState(this.newPokemon, this.newShowSelectTeam, this.newInicio,
      this.newIsLoading)
      : super(
            existData: true,
            pokemon: newPokemon,
            showSelectTeam: newShowSelectTeam,
            inicio: newInicio,
            isLoading: newIsLoading);
}
