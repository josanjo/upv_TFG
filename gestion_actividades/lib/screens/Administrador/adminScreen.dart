// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../../utils/Pantallas.dart';
import '../../widgets/menuPrincipal.dart';
import '../../widgets/contenedorClickable.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);
  static const routeName = '/adminScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MenuPrincipal(context),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Center(
                    child: ContenedorClickable(
                      accion: 'Añadir usuario',
                      ruta: CrearUsuarios.routeName,
                    ),
                  ),
                  Center(
                    child: ContenedorClickable(
                      accion: 'Añadir entrenador',
                      ruta: CrearEntrenador.routeName,
                    ),
                  ),
                  Center(
                    child: ContenedorClickable(
                      accion: 'Eliminar cuenta',
                      ruta: Listados.routeName,
                    ),
                  ),
                  Center(
                    child: ContenedorClickable(
                      accion: 'Leer mensajes',
                      ruta: Mensajes.routeName,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
