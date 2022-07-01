import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  final String mensaje;

  const CustomProgressIndicator({Key? key, required this.mensaje})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50.0),
      child: Column(children: [
        CircularProgressIndicator(
            backgroundColor: Colors.indigo[300],
            valueColor: const AlwaysStoppedAnimation(Colors.indigo)),
        Padding(padding: const EdgeInsets.all(8.0), child: Text(mensaje))
      ]),
    );
  }
}
