import 'package:flutter/material.dart';
import 'package:gestion_actividades/widgets/pasosCreacion.dart';

import '../../widgets/menuPrincipal.dart';

class FormularioEntrenamientos extends StatelessWidget {
  const FormularioEntrenamientos({Key? key}) : super(key: key);
  static const routeName = '/formularioEntrenamientos';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MenuPrincipal(context),
      body: SafeArea(
        child: Container(
            width: deviceSize.width,
            height: deviceSize.height,
            child: const PasosCreacion()),
      ),
    );
  }
}
