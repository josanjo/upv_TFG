// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:gestion_actividades/utils/Pantallas.dart';

import '../../utils/Textos.dart';
import '../../widgets/opcionesEntrenador.dart';
import '../../widgets/menuPrincipal.dart';

class EntrenadorScreen extends StatelessWidget {
  const EntrenadorScreen({Key? key}) : super(key: key);
  static const routeName = '/entrenadorScreen';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MenuPrincipal(context),
      body: Stack(
        children: <Widget>[
          Container(
            height: deviceSize.height * 0.5,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 24, 26, 24),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 15),
                  Expanded(
                    flex: 6,
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .85,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: const <Widget>[
                        SizedBox(
                          child: Text(
                            'Hola, entrenador',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: Textos.fuentePrincipal,
                                fontSize: 30),
                          ),
                        ),
                        OpcionesEntrenador(
                            title: "Añadir entrenamiento",
                            svgSrc: Icons.add,
                            ruta: FormularioEntrenamientos.routeName),
                        OpcionesEntrenador(
                          title: "Usuarios",
                          svgSrc: Icons.switch_account_sharp,
                          ruta: ListadoUsuarios.routeName,
                        ),
                        OpcionesEntrenador(
                          svgSrc: Icons.bar_chart_outlined,
                          title: "Enviar mensaje",
                          ruta: EnviarMensaje.routeName,
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Image.asset(
                        'assets/images/chico.png',
                        height: deviceSize.width * 0.6,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
