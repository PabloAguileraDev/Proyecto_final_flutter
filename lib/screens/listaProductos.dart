import 'package:flutter/material.dart';

class ListaProductos extends ChangeNotifier {
  //Lista que almacena ids de productos
  final List<int> listaGlobal = [];

  //Obtener la lista actual
  List<int> get lista => List.unmodifiable(listaGlobal);

  //Añadir un id a la lista
  void addProduct(int productoId) {
    if (!listaGlobal.contains(productoId)) {
      listaGlobal.add(productoId);
      notifyListeners();
    }
  }

  //Eliminar un id de la lista
  void deleteProduct(int productoId) {
    if (listaGlobal.contains(productoId)) {
      listaGlobal.remove(productoId);
      notifyListeners();
    }
  }
}
