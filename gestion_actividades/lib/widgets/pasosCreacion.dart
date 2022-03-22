import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../entities/actividades.dart';
import '../utils/Textos.dart';

class PasosCreacion extends StatefulWidget {
  const PasosCreacion({Key? key}) : super(key: key);

  @override
  State<PasosCreacion> createState() => _PasosCreacionState();
}

class _PasosCreacionState extends State<PasosCreacion> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _nombreEntrenoController = TextEditingController();
  final _duracionController = TextEditingController();
  List<Actividades> arrayActividades = [];

  int _index = 0;
  late String identificador;
  late DateTime fechaEjercicio;
  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    setState(() {
      _index = 0;
      identificador = 'ninguno';
      fechaEjercicio = DateTime.now();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
      controlsBuilder: (context, _) {
        return Row(
          children: <Widget>[
            TextButton(
              onPressed: () {
                if (_index < 2) {
                  setState(() {
                    _index += 1;
                  });
                }
              },
              child: const Text('SIGUIENTE'),
            ),
            TextButton(
              onPressed: () {
                if (_index > 0) {
                  setState(() {
                    _index -= 1;
                  });
                }
              },
              child: const Text('ATRÁS'),
            ),
          ],
        );
      },
      currentStep: _index,
      onStepContinue: () {
        _index < 2 ? setState(() => _index += 1) : null;
      },
      onStepTapped: (int index) {
        setState(() {
          _index = index;
        });
      },
      steps: <Step>[
        Step(
          title: const Text('PASO 1: SELECCIONA UN USUARIO',
              style: TextStyle(
                  fontFamily: Textos.fuentePrincipal,
                  fontSize: Textos.tamanyoFuente3)),
          content: Container(
            height: 300,
            width: MediaQuery.of(context).size.width * 0.8,
            alignment: Alignment.centerLeft,
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  db.collection('Usuarios').orderBy("Apellidos").snapshots(),
              builder: (
                context,
                AsyncSnapshot snapshot,
              ) {
                return snapshot.hasData
                    ? ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(10),
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot ds = snapshot.data.docs[index];
                          return SizedBox(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        flex: 5,
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(ds["Apellidos"] + ',',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15)),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 3,
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(ds["Nombre"],
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15)),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: IconButton(
                                          icon:
                                              const Icon(Icons.person_outline),
                                          color: const Color.fromARGB(
                                              255, 75, 84, 116),
                                          onPressed: () => {
                                            setState(() {
                                              identificador = ds.id;
                                              fechaEjercicio = DateTime.now();
                                              _index += 1;
                                            })
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(color: Colors.white),
                              ],
                            ),
                          );
                        },
                      )
                    : const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
        Step(
          title: const Text('PASO 2: SELECCIONA UNA FECHA',
              style: TextStyle(
                  fontFamily: Textos.fuentePrincipal,
                  fontSize: Textos.tamanyoFuente3)),
          content: Container(
            height: 300,
            width: MediaQuery.of(context).size.width * 0.8,
            child: CupertinoTheme(
              data: const CupertinoThemeData(
                primaryColor: Colors.white,
                brightness: Brightness.dark,
              ),
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime(1997, 1, 1),
                onDateTimeChanged: (DateTime seleccion) {
                  setState(() {
                    fechaEjercicio = seleccion;
                  });
                },
                use24hFormat: false,
              ),
            ),
          ),
        ),
        Step(
          title: const Text('PASO 3: CREA EL EJERCICIO',
              style: TextStyle(
                  fontFamily: Textos.fuentePrincipal,
                  fontSize: Textos.tamanyoFuente3)),
          content: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(
                      fontFamily: Textos.fuentePrincipal,
                      fontSize: Textos.tamanyoFuente2,
                    ),
                    labelText: 'Nombre del ejercicio',
                    labelStyle: TextStyle(
                      fontFamily: Textos.fuentePrincipal,
                      fontSize: Textos.tamanyoFuente3,
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  controller: _nombreEntrenoController,
                  validator: (value) {
                    if (value == null) {
                      return "Agrega un nombre";
                    }
                    //value.isEmpty ||
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(
                      fontFamily: Textos.fuentePrincipal,
                      fontSize: Textos.tamanyoFuente2,
                    ),
                    labelText: 'Duración en SEGUNDOS',
                    labelStyle: TextStyle(
                      fontFamily: Textos.fuentePrincipal,
                      fontSize: Textos.tamanyoFuente3,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  controller: _duracionController,
                  validator: (value) {
                    if (value == null) {
                      return 'Agrega duración';
                    } else {
                      return null;
                    }
                  },
                ),
                Row(children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        child: const Text(
                          'Añadir',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: Textos.fuentePrincipal,
                            fontSize: Textos.tamanyoFuente3,
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            anyadirActividad(
                              _nombreEntrenoController.text,
                              int.parse(_duracionController.text),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  Flexible(flex: 1, child: Container(width: 10)),
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        child: const Text(
                          'Guardar',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: Textos.fuentePrincipal,
                            fontSize: Textos.tamanyoFuente3,
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            enviarEjercicio(identificador, fechaEjercicio,
                                arrayActividades);
                          }
                        },
                      ),
                    ),
                  ),
                ])
              ],
            ),
          ),
        ),
      ],
    );
  }

  void anyadirActividad(String titulo, int duracion) {
    Actividades actividad = Actividades(titulo, duracion);
    arrayActividades.add(actividad);

    print(arrayActividades.toString());
  }
}

void enviarEjercicio(
  String identificador,
  DateTime fecha,
  var arrayActividades,
) {
  DateTime formateada =
      DateTime(fecha.year, fecha.month, fecha.day, 12, 00, 00, 0000, 0000);
  Timestamp fechaActividad = Timestamp.fromDate(formateada);

  Map<String, dynamic> data = {
    "Usuario": identificador,
    "Fecha": fechaActividad,
    "Actividades": convertirMap(actividades: arrayActividades)
  };

  FirebaseFirestore.instance.collection("Entrenamientos").add(data);

//SET TODO
}

List<Map> convertirMap({required List<Actividades> actividades}) {
  List<Map> steps = [];
  for (var actividades in actividades) {
    Map<String, dynamic> step = actividades.toMap();
    steps.add(step);
  }
  return steps;
}
