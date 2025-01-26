import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final_flutter/routes/routes.dart';
import 'package:proyecto_final_flutter/screens/listaProductos.dart';
import 'package:proyecto_final_flutter/screens/pantallaInicio.dart';

void main() {
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
      title: 'Lista del Mercadona',
      theme: ThemeData(
        primaryColor: const Color(0xFF4CAF50), // Verde suave (color principal)
        scaffoldBackgroundColor: const Color(0xFFF9F9F9), // Fondo gris claro
        cardColor: Colors.white, // Tarjetas blancas
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
              color: Color(0xFF212121), fontSize: 14), // Texto principal
          bodyMedium: TextStyle(
              color: Color(0xFF757575), fontSize: 12), // Texto secundario
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF4CAF50), // Color primario (verde)
          secondary: const Color(0xFFFF9800), // Color secundario (naranja)
        ),
        appBarTheme: const AppBarTheme(
          color: Color(0xFF4CAF50), // AppBar verde
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFFFF9800), // Botones principales en naranja
          textTheme: ButtonTextTheme.primary, // Texto blanco sobre botones
        ),
      ),
      home: const PantallaInicio(),
      routes: AppRoutes.staticRoutes,
    );
  }
}
