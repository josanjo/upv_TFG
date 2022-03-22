import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListaMensajes extends StatelessWidget {
  const ListaMensajes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return StreamBuilder<QuerySnapshot>(
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
                        color: Colors.white,
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: Text(ds["Entrenador"],
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 15)),
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
                                color: const Color.fromARGB(255, 57, 72, 80),
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
    );
  }
}
