import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AlternaListado extends StatelessWidget {
  final bool tipoPermisos;
  final String queryTipo;

  const AlternaListado(
      {Key? key, required this.tipoPermisos, required this.queryTipo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: db.collection(queryTipo).snapshots(),
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
                    return Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            decoration: const BoxDecoration(
                                border: Border(
                              bottom: BorderSide(color: Colors.white),
                            )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  flex: 2,
                                  child: Text(ds["Nombre"],
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 15)),
                                ),
                                const Divider(color: Colors.white),
                                Flexible(
                                  flex: 2,
                                  child: Text(
                                    ds["Apellidos"],
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Text(
                                    ds["Edad"],
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: IconButton(
                                    icon: const Icon(Icons.delete),
                                    color: const Color.fromARGB(
                                        255, 203, 210, 214),
                                    tooltip: 'Eliminar',
                                    onPressed: () => {eliminar(ds.id)},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  })
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<void> eliminar(String id) async {
    FirebaseFirestore.instance.collection(queryTipo).doc(id).delete();
    FirebaseDatabase.instance.ref().child('usuarios/$id').remove();
  }
}
