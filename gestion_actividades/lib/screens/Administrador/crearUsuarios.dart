// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../entities/usuario.dart';
import '../../utils/FireBaseUtils.dart';
import '../../utils/Textos.dart';
import '../../widgets/menuPrincipal.dart';

class CrearUsuarios extends StatefulWidget {
  const CrearUsuarios({Key? key}) : super(key: key);
  static const routeName = '/CrearUsuarios';

  @override
  State<CrearUsuarios> createState() => _State();
}

class _State extends State<CrearUsuarios> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _nombreController = TextEditingController();
  final _apellidosController = TextEditingController();
  final _edadController = TextEditingController();
  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MenuPrincipal(context),
      body: SafeArea(
        child: Container(
          width: deviceSize.width,
          height: deviceSize.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: const Text('AÑADE UN USUARIO'),
                ),
              ),
              Flexible(
                flex: 4,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 20.0,
                  child: Container(
                    height: deviceSize.height * 0.8,
                    constraints: const BoxConstraints(minHeight: 260),
                    width: deviceSize.width * 0.75,
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(children: <Widget>[
                          TextFormField(
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(
                                fontFamily: Textos.fuentePrincipal,
                                fontSize: Textos.tamanyoFuente2,
                              ),
                              labelText: Textos.emailLogin,
                              labelStyle: TextStyle(
                                fontFamily: Textos.fuentePrincipal,
                                fontSize: Textos.tamanyoFuente3,
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            controller: _emailController,
                            validator: (value) {
                              if (value == null) {
                                return "Email invalido";
                              }
                              if (!value.contains('@')) {
                                return 'Formato incorrecto';
                              }
                              if (value.isEmpty) {
                                return Textos.emailVacio;
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
                              labelText: Textos.passLogin,
                              labelStyle: TextStyle(
                                fontFamily: Textos.fuentePrincipal,
                                fontSize: Textos.tamanyoFuente3,
                              ),
                            ),
                            obscureText: true,
                            controller: _passwordController,
                            validator: (value) {
                              if (_passwordController.text.length < 5) {
                                return 'La contraseña debe tener mínimo 5 carácteres';
                              } else if (value!.isEmpty) {
                                return Textos.passVacia;
                              } else {
                                return null;
                              }
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(
                                fontFamily: Textos.fuentePrincipal,
                                fontSize: Textos.tamanyoFuente2,
                              ),
                              labelText: 'Nombre',
                              labelStyle: TextStyle(
                                fontFamily: Textos.fuentePrincipal,
                                fontSize: Textos.tamanyoFuente3,
                              ),
                            ),
                            controller: _nombreController,
                            validator: (value) {
                              if (value == null) {
                                return "Nombre invalido";
                              }
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(
                                fontFamily: Textos.fuentePrincipal,
                                fontSize: Textos.tamanyoFuente2,
                              ),
                              labelText: 'Apellidos',
                              labelStyle: TextStyle(
                                fontFamily: Textos.fuentePrincipal,
                                fontSize: Textos.tamanyoFuente3,
                              ),
                            ),
                            controller: _apellidosController,
                            validator: (value) {
                              if (value == null) {
                                return "Apellidos invalido";
                              }
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(
                                fontFamily: Textos.fuentePrincipal,
                                fontSize: Textos.tamanyoFuente2,
                              ),
                              labelText: 'Edad',
                              labelStyle: TextStyle(
                                fontFamily: Textos.fuentePrincipal,
                                fontSize: Textos.tamanyoFuente3,
                              ),
                            ),
                            controller: _edadController,
                            validator: (value) {
                              if (value == null) {
                                return "edad invalido";
                              }
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(
                                fontFamily: Textos.fuentePrincipal,
                                fontSize: Textos.tamanyoFuente2,
                              ),
                              labelText: 'Peso',
                              labelStyle: TextStyle(
                                fontFamily: Textos.fuentePrincipal,
                                fontSize: Textos.tamanyoFuente3,
                              ),
                            ),
                            controller: _pesoController,
                            validator: (value) {
                              if (value == null) {
                                return "Peso invalido";
                              }
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(
                                fontFamily: Textos.fuentePrincipal,
                                fontSize: Textos.tamanyoFuente2,
                              ),
                              labelText: 'Altura',
                              labelStyle: TextStyle(
                                fontFamily: Textos.fuentePrincipal,
                                fontSize: Textos.tamanyoFuente3,
                              ),
                            ),
                            controller: _alturaController,
                            validator: (value) {
                              if (value == null) {
                                return "Altura invalido";
                              }
                            },
                          ),
                          ElevatedButton(
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
                                Usuario usuario = Usuario(
                                    _nombreController.text,
                                    _apellidosController.text,
                                    _edadController.text,
                                    _emailController.text,
                                    _passwordController.text,
                                    _pesoController.text,
                                    _alturaController.text);
                                FireBaseUtils().crearUsuarios(context, usuario);
                              }
                            },
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
