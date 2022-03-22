import 'package:flutter/material.dart';

class OpcionesEntrenador extends StatelessWidget {
  final IconData svgSrc;
  final String title;
  final String ruta;

  const OpcionesEntrenador({
    Key? key,
    required this.svgSrc,
    required this.title,
    required this.ruta,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        // padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => {Navigator.pushNamed(context, ruta)},
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  const Spacer(),
                  Icon(svgSrc, color: Colors.black, size: 40),
                  const Spacer(),
                  Text(title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
