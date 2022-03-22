import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gestion_actividades/widgets/alternaListado.dart';

import '../../utils/Textos.dart';
import '../../widgets/menuPrincipal.dart';

class Listados extends StatefulWidget {
  const Listados({Key? key}) : super(key: key);
  static const routeName = '/listados';
  @override
  State<Listados> createState() => _ListadoState();
}

class _ListadoState extends State<Listados> {
  var tipoPermisos = true;
  late String boton = 'Usuarios';

  @override
  void initState() {
    setState(() {
      boton = 'Usuarios';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MenuPrincipal(context),
      body: SafeArea(
        child: Container(
          width: deviceSize.width,
          height: deviceSize.height,
          child: Column(
            children: <Widget>[
              ElevatedButton(
                child: Text(
                  boton,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: Textos.fuentePrincipal,
                    fontSize: Textos.tamanyoFuente3,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    tipoPermisos = !tipoPermisos;
                    boton = (tipoPermisos) ? 'Usuarios' : 'Entrenadores';
                  });
                },
              ),
              AlternaListado(
                tipoPermisos: tipoPermisos,
                queryTipo: boton,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
