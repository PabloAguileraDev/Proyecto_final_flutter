import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final_flutter/routes/routes.dart';
import 'package:proyecto_final_flutter/services/firebaseService.dart';
import 'package:proyecto_final_flutter/screens/pantallaInicio.dart';

//Clase principal
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    ChangeNotifierProvider(
      create: (context) => ListaProductos(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de la compra',
      theme: ThemeData(
        primaryColor: const Color(0xFF4CAF50),
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
        cardColor: Colors.white,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
              color: Color(0xFF212121), fontSize: 14, fontFamily: 'Poppins'),
          bodyMedium: TextStyle(
              color: Color(0xFF757575), fontSize: 12, fontFamily: 'Poppins'),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF4CAF50),
          secondary: const Color(0xFFFF9800),
        ),
        appBarTheme: const AppBarTheme(
          color: Color(0xFF4CAF50),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFFFF9800),
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: const PantallaInicio(),
      routes: AppRoutes.staticRoutes,
    );
  }
}
