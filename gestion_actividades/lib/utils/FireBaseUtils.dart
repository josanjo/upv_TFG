// ignore_for_file: file_names, unrelated_type_equality_checks, unnecessary_null_comparison
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../entities/entrenador.dart';
import '../entities/usuario.dart';
import '../utils/Pantallas.dart';

class FireBaseUtils {
  Future<void> logIn(BuildContext ctx, String email, String password) async {
    //VERIFICACIÓN
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseAuth.instance.userChanges().listen((User? user) {
        //VALIDO PERMISOS
        if (user != null) {
          getPermisos(user.uid.toString(), ctx);
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == "REVOKED_ID_TOKEN") {
        debugPrint("El token ha expirado");
      } else {
        debugPrint("Token inválido");
      }
    }
  }

  Future<LoginScreen> logOut(BuildContext ctx) async {
    await FirebaseAuth.instance.signOut().then((value) => Navigator.of(ctx)
        .pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false));
    return const LoginScreen();
  }

  Future<void> getPermisos(String identificador, BuildContext ctx) async {
    String ruta = '/';
    final ref = FirebaseDatabase.instance.ref();
    await ref
        .child('usuarios/$identificador')
        .child('permisos')
        .get()
        .then((result) => {
              if (result.exists) {eligeRuta(result.value.toString(), ctx)}
            });
  }

  Future<StatelessWidget> crearEntrenador(
      BuildContext ctx, Entrenador entrenador) async {
    final ref = FirebaseDatabase.instance.ref("usuarios");
    String uID = '';
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: entrenador.email, password: entrenador.password)
          .then((value) => {
                if (value != null && value.user != null)
                  {
                    uID = value.user!.uid.toString(),
                    ref.child(uID).set({"permisos": 'ENTRENADOR'})
                  }
                else
                  {throw Error()}
              })
          .then((result) => {
                FirebaseFirestore.instance
                    .collection('Entrenadores')
                    .doc(uID)
                    .set({
                  "Nombre": entrenador.nombre,
                  "Apellidos": entrenador.apellidos,
                  "Edad": entrenador.edad,
                  "Identificador": uID
                })
              })
          .then((result) => {
                Navigator.of(ctx).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const AdminScreen()),
                    (route) => false)
              });

      return const AdminScreen();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('Contraseña debil');
      } else if (e.code == 'email-already-in-use') {
        print('Este correo ya existe');
      }
    } catch (e) {
      return const ErrorScreen();
    }
    return const ErrorScreen();
  }

  Future<StatelessWidget> crearUsuarios(
      BuildContext ctx, Usuario usuario) async {
    final ref = FirebaseDatabase.instance.ref("usuarios");
    String uID = '';
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: usuario.email, password: usuario.password)
          .then((value) => {
                if (value != null && value.user != null)
                  {
                    uID = value.user!.uid.toString(),
                    ref.child(uID).set({"permisos": 'USUARIO'})
                  }
                else
                  {throw Error()}
              })
          .then((result) => {
                FirebaseFirestore.instance.collection('Usuarios').doc(uID).set({
                  "Nombre": usuario.nombre,
                  "Apellidos": usuario.apellidos,
                  "Edad": usuario.edad,
                  "Altura": usuario.altura,
                  "Peso": usuario.peso,
                  "Identificador": uID
                })
              })
          .then((result) => {
                Navigator.of(ctx).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const AdminScreen()),
                    (route) => false)
              });

      return const AdminScreen();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('Contraseña debil');
      } else if (e.code == 'email-already-in-use') {
        print('Este correo ya existe');
      }
    } catch (e) {
      return const ErrorScreen();
    }
    return const ErrorScreen();
  }

  void eligeRuta(String result, BuildContext ctx) {
    String ruta;

    if (result == 'ADMIN') {
      ruta = AdminScreen.routeName;
    } else if (result == 'ENTRENADOR') {
      ruta = EntrenadorScreen.routeName;
    } else if (result == 'USUARIO') {
      ruta = UsuarioScreen.routeName;
    } else {
      ruta = ErrorScreen.routeName;
    }
    Navigator.of(ctx).pushNamedAndRemoveUntil(ruta, (route) => false);
  }
}
