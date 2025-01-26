import 'package:flutter/material.dart';
import '../screens/screens.dart';

class AppRoutes {
  // Definir nombres para las rutas
  static const String pantallaInicio = '/pantallaInicio';
  static const String lista = '/lista';
  static const String productos = '/productos';

  // Mapa de rutas estáticas
  static final Map<String, WidgetBuilder> staticRoutes = {
    pantallaInicio: (context) => const PantallaInicio(),
    lista: (context) => const Lista(),
    productos: (context) => const Productos(),
  };
}
