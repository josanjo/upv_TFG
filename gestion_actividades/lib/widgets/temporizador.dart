import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class Temporizador extends StatefulWidget {
  //final List<Map<String, String>> actividades;
  const Temporizador({
    Key? key,
    //required this.actividades,
  }) : super(key: key);

  @override
  State<Temporizador> createState() => _State();
}

class _State extends State<Temporizador> {
  final List<Map<String, String>> _duracion = [
    {"Duracion": '4'.toString(), "Titulo": 'Mancuernas'},
    {"Duracion": '3'.toString(), "Titulo": 'Lanzamiento'},
    {"Duracion": '2'.toString(), "Titulo": 'PertigA'},
  ];
  //late final List<Map<String, String>> _duracion;
  String a = '';
  bool flag = true;
  late Timer _timer;
  int recorreBucle = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Builder(
          builder: (_) => (flag)
              ? Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 150,
                          height: 150,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: FittedBox(
                            child:
                                Text('${_duracion[recorreBucle]['Duracion']}'),
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 20,
                          child: FittedBox(
                            child: Text(
                              '${_duracion[recorreBucle]['Titulo']}',
                              style: const TextStyle(fontSize: 30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Expanded(
                  child: Center(
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: const FittedBox(
                        child: Text('TERMINADO!'),
                      ),
                    ),
                  ),
                ),
        ),
        Center(
          child: Builder(
              builder: (_) => (flag)
                  ? ElevatedButton(
                      child: const Text('Comenzar'),
                      onPressed: _startTimer,
                    )
                  : ElevatedButton(
                      child: const Text('Salir'),
                      onPressed: () => Navigator.pop(_),
                    )),
        ),
      ],
    );
  }

//recorreBucle = lo que se muestra
//_duracion = list<Map>
  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      setState(() {
        if (int.parse(_duracion[recorreBucle]['Duracion']!) > 0) {
          _duracion[recorreBucle]['Duracion'] =
              (int.parse(_duracion[recorreBucle]['Duracion']!) - 1).toString();
        } else {
          if (recorreBucle != (_duracion.length - 1)) {
            recorreBucle++;
          } else {
            flag = false;
            timer.cancel();
          }
        }
      });
    });
  }

  @override
  void initState() {
    //_duracion = widget.actividades;
    _timer = Timer(const Duration(milliseconds: 500), () {
      // SOMETHING
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
