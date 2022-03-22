//SCREENS
import 'package:gestion_actividades/utils/Pantallas.dart';

//FLUTTER
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SPORT',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        fontFamily: "Nunito-Regular",
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyText1: TextStyle(
            fontSize: 10,
            fontFamily: 'Nunito-Regular',
            color: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.lightBlue[800],
          ),
        ),
      ),
      //home: const LoginScreen(),
      routes: {
        '/': (_) => const LoginScreen(),

        //ADMINISTRADOR
        AdminScreen.routeName: (context) => const AdminScreen(),
        CrearUsuarios.routeName: (context) => const CrearUsuarios(),
        CrearEntrenador.routeName: (context) => const CrearEntrenador(),
        Mensajes.routeName: (context) => const Mensajes(),
        Listados.routeName: (context) => const Listados(),

        //ENTRENADOR
        EntrenadorScreen.routeName: (context) => const EntrenadorScreen(),
        ListadoUsuarios.routeName: (context) => const ListadoUsuarios(),
        EnviarMensaje.routeName: (context) => const EnviarMensaje(),
        FormularioEntrenamientos.routeName: (context) =>
            const FormularioEntrenamientos(),

        //USUARIO
        UsuarioScreen.routeName: (context) => const UsuarioScreen(),

        //GENERAL
        ErrorScreen.routeName: (context) => const ErrorScreen(),
      },
    );
  }
}
