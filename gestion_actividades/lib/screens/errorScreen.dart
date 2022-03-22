// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../utils/Textos.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);
  static const routeName = '/errorScreen';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          Textos.errorAplicacion,
          style: TextStyle(
            color: Textos.colorTextos2,
            fontFamily: Textos.fuentePrincipal,
            fontSize: Textos.tamanyoFuente1,
          ),
        ),
      ],
    );
  }
}
