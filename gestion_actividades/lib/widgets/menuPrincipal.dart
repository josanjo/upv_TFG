// ignore_for_file: file_names
import '../utils/FireBaseUtils.dart';
import 'package:flutter/material.dart';
import '../utils/Textos.dart';

class MenuPrincipal extends AppBar {
  MenuPrincipal(BuildContext context, {Key? key})
      : super(
          key: key,
          actions: [
            IconButton(
              icon: const Icon(Icons.login_outlined),
              onPressed: () => FireBaseUtils().logOut(context),
              color: Colors.white,
            ),
          ],
          centerTitle: true,
          title: const Text(
            Textos.tituloApp,
            style: TextStyle(
              color: Textos.colorTextos1,
              fontFamily: Textos.fuentePrincipal,
              fontSize: Textos.tamanyoFuente1 * 1.5,
            ),
          ),
        );
}
