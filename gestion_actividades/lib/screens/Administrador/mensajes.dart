import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../widgets/menuPrincipal.dart';

class Mensajes extends StatelessWidget {
  const Mensajes({Key? key}) : super(key: key);
  static const routeName = '/mensajes';

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: MenuPrincipal(context),
        body: SafeArea(
          child: Container(
            width: deviceSize.width,
            height: deviceSize.height,
            child: StreamBuilder<QuerySnapshot>(
              stream: db
                  .collection("Mensajes")
                  .where("Leido", isEqualTo: false)
                  //          .orderBy('Leido', descending: true)
                  .snapshots(),
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
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromARGB(255, 9, 12, 9),
                                        spreadRadius: 3),
                                  ],
                                  color: Colors.white,
                                  border: Border(
                                    bottom: BorderSide(
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      flex: 1,
                                      child: Text(ds["Entrenador"],
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15)),
                                    ),
                                    Flexible(
                                      flex: 4,
                                      child: Text(
                                        ds["Texto"],
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: IconButton(
                                        icon: const Icon(Icons.delete),
                                        color: const Color.fromARGB(
                                            255, 57, 72, 80),
                                        tooltip: 'Eliminar mensaje',
                                        onPressed: () => {
                                          FirebaseFirestore.instance
                                              .collection('Mensajes')
                                              .doc(ds.id)
                                              .update({'Leido': true})
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        })
                    : const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ));
  }
}
