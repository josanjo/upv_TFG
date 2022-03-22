import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/menuPrincipal.dart';
import '../../widgets/temporizador.dart';

class UsuarioEntrenamiento extends StatelessWidget {
  static const routeName = '/usuarioEntrenamiento';
  final Timestamp fechaElegida;
  List<Map<String, String>> actividades = [];

  UsuarioEntrenamiento(this.fechaElegida) {
    actividades = getActividades();
  }

  @override
  Widget build(BuildContext context) {
    print(fechaElegida);
    return Scaffold(
      appBar: MenuPrincipal(context),
      body: Center(
        child: Temporizador(
            // actividades: actividades,
            ),
      ),
    );
  }

  // Future<List<Map<String, String>>> getAActividades(Timestamp fecha) async {
  List<Map<String, String>> getActividades() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore referencia = FirebaseFirestore.instance;
    String uid = auth.currentUser!.uid;
    List<Map<String, String>> actividades = [];
    referencia
        .collection("Entrenamientos")
        .where("Usuario", isEqualTo: uid)
        .where("Fecha", isEqualTo: fechaElegida)
        //.limitToLast(1)
        //.orderBy(uid)
        .get()
        .then((QuerySnapshot querySnapshot) =>
            {actividades = querySnapshot.docs[0].get("Actividades")});
    return actividades;
  }
}
