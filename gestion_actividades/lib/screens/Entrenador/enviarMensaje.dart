import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../utils/Textos.dart';
import '../../widgets/menuPrincipal.dart';

class EnviarMensaje extends StatefulWidget {
  static const routeName = '/enviarMensaje';

  const EnviarMensaje({Key? key}) : super(key: key);

  @override
  State<EnviarMensaje> createState() => _EnviarMensajeState();
}

class _EnviarMensajeState extends State<EnviarMensaje> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool enviado = false;
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MenuPrincipal(context),
      body: Center(
        child: Container(
          width: deviceSize.width * 0.7,
          height: deviceSize.height,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      height: deviceSize.height * 0.3,
                      padding: const EdgeInsets.all(10),
                      child: const Text('ESCRIBE AL ADMINISTRADOR',
                          style: TextStyle(
                              fontFamily: Textos.fuentePrincipal,
                              fontSize: 25))),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(
                        fontFamily: Textos.fuentePrincipal,
                        fontSize: Textos.tamanyoFuente2,
                      ),
                      labelText: 'Introduce un comentario',
                      labelStyle: TextStyle(
                        fontFamily: Textos.fuentePrincipal,
                        fontSize: Textos.tamanyoFuente3,
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    controller: _textController,
                    validator: (value) {
                      if (value == null) {
                        return "Email invalido";
                      }
                      if (value.length > 30) {
                        return 'Mensaje demasiado largo';
                      }
                      if (value.isEmpty) {
                        return Textos.emailVacio;
                      }
                      //value.isEmpty ||
                      return null;
                    },
                  ),
                  ElevatedButton(
                    child: const Text(
                      'ENVIAR MENSAJE',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: Textos.fuentePrincipal,
                        fontSize: Textos.tamanyoFuente3,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        updateMensajes(_textController.text);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateMensajes(String texto) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    String nombre = "";
    bool flag = true;
    final uid = auth.currentUser?.uid;
    await FirebaseFirestore.instance
        .collection('Entrenadores')
        .doc(uid)
        .get()
        .then((result) => {nombre = result["Nombre"]})
        .then((value) => {
              FirebaseFirestore.instance
                  .collection('Mensajes')
                  .add({"Entrenador": nombre, "Texto": texto, "Leido": flag})
            });
  }
}
