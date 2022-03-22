import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../widgets/alternaListado.dart';
import '../../widgets/menuPrincipal.dart';

class ListadoUsuarios extends StatelessWidget {
  const ListadoUsuarios({Key? key}) : super(key: key);
  static const routeName = '/listadoUsuarios';

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return Scaffold(
      appBar: MenuPrincipal(context),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: db.collection("Usuarios").snapshots(),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
      ),
    );
  }
}
