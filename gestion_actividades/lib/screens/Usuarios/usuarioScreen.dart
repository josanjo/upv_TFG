// ignore_for_file: file_names
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:gestion_actividades/screens/Usuarios/usuarioEntrenamiento.dart';
import '../../widgets/menuPrincipal.dart';
import 'package:calendar_appbar/calendar_appbar.dart';

class UsuarioScreen extends StatelessWidget {
  const UsuarioScreen({Key? key}) : super(key: key);

  static const routeName = '/usuarioScreen';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MenuPrincipal(context),
      body: Center(
        child: Column(children: <Widget>[
          const Flexible(
            flex: 2,
            child: Calendario(),
          ),
          Flexible(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: Image.asset(
                'assets/images/chica.png',
                height: deviceSize.width * 0.8,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ]),
      ),
    );
    //
  }
}

class Calendario extends StatefulWidget {
  const Calendario({Key? key}) : super(key: key);

  @override
  _Calendario createState() => _Calendario();
}

class _Calendario extends State<Calendario> {
  DateTime? selectedDate;
  bool flag = false;

  @override
  void initState() {
    setState(() {
      selectedDate = DateTime.now();
    });
    super.initState();
  }

  @override
  Widget build(_) {
    late List<DateTime> lista;
    final db = FirebaseFirestore.instance;
    return StreamBuilder<QuerySnapshot>(
      stream: db
          .collection("Entrenamientos")
          .where("Usuario", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (
        context,
        AsyncSnapshot snapshot,
      ) {
        if (snapshot.hasError) {
          return const Text('Ha ocurrido un problema');
        }
        if (snapshot.hasData) {
          //PARA COGERLOS TODOS
          //final allData = snapshot.data.docs.map((doc) => doc.data()).toList();

          final fechasTimes = snapshot.data.docs
              .map((doc) => doc.data()["Fecha"].toDate())
              .toList();
          lista = List.castFrom(fechasTimes);

          final allData = snapshot.data.docs.map((doc) => doc.data()).toList();
          print(allData);
        }
        //var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

        return snapshot.hasData
            ? Scaffold(
                appBar: CalendarAppBar(
                  fullCalendar: true,
                  backButton: false,
                  locale: 'es',
                  accent: const Color.fromARGB(255, 0, 0, 0),
                  onDateChanged: (value) => setState(() {
                    selectedDate = value;
                    flag = (lista.contains(selectedDate)) ? true : false;
                  }),
                  lastDate: DateTime.now(),
                  events: lista,
                ),
                //Text(selectedDate.toString())
                body: Center(
                  child: Builder(
                    builder: (_) {
                      return ElevatedButton(
                          child: const Text('Entrenamiento'),
                          onPressed: (flag)
                              ? () async {
                                  if (selectedDate != null) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UsuarioEntrenamiento(
                                                  Timestamp.fromDate(
                                                      selectedDate!),
                                                )));
                                  }
                                }
                              : null);
                    },
                  ),
                ),
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}
