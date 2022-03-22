import 'package:flutter/material.dart';
import '../utils/Textos.dart';

class ContenedorClickable extends StatelessWidget {
  final String accion;
  final String ruta;

  const ContenedorClickable({
    Key? key,
    required this.accion,
    required this.ruta,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SizedBox(
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 57, 72, 80),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.only(left: 10.0),
          width: double.infinity,
          height: 35,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    accion,
                    style: const TextStyle(
                      fontFamily: Textos.fuentePrincipal,
                      fontSize: 15,
                      color: Textos.colorTextos1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, ruta);
      },
    );
  }
}
