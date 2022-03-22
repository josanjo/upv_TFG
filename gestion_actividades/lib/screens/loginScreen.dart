// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../utils/Textos.dart';
import '../utils/FireBaseUtils.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 62, 62, 97).withOpacity(0.6),
                  const Color.fromARGB(255, 4, 5, 7).withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Image.asset(
                      'assets/images/logoApp.png',
                      height: deviceSize.width * 0.6,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: const AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      color: Colors.blueGrey.shade600,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 20.0,
      child: Container(
        height: 280,
        constraints: const BoxConstraints(minHeight: 260),
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
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
                  validator: (value) =>
                      value!.isEmpty ? Textos.passVacia : null,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text(
                    Textos.accederApp,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: Textos.fuentePrincipal,
                      fontSize: Textos.tamanyoFuente3,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      FireBaseUtils().logIn(
                        context,
                        _emailController.text.toString(),
                        _passwordController.text.toString(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
