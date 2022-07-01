import 'package:flutter/material.dart';

Color? colorPokemon(String tipo) {
  switch (tipo) {
    case 'fire':
      return Colors.red[400];
    case 'water':
      return Colors.blue[400];
    case 'bug':
      return Colors.lightGreen[400];
    case 'normal':
      return Colors.grey[400];
    case 'poison':
      return Colors.purple[400];
    case 'electric':
      return Colors.yellow[400];
    case 'ground':
      return Colors.brown[400];
    case 'fairy':
      return Colors.pink[400];
    case 'grass':
      return Colors.green[400];
    default:
      return Colors.amber[700];
  }
}
