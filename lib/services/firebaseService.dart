import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListaProductos extends ChangeNotifier {
  //Lista que almacena ids de productos
  List<int> listaGlobal = [];
  final FirebaseFirestore bd = FirebaseFirestore.instance;
  final String documentId = "productos";
  final String collectionId = "lista";

  ListaProductos() {
    getListaFirebase();
  }

  //Obtener la lista actual
  List<int> get lista => List.unmodifiable(listaGlobal);

  //Añadir un producto a la lista
  Future<void> addProduct(int productoId) async {
    if (!listaGlobal.contains(productoId)) {
      listaGlobal.add(productoId);
      notifyListeners();
      await updateListaFirebase();
    }
  }

  //Eliminar un producto de la lista
  Future<void> deleteProduct(int productoId) async {
    if (listaGlobal.contains(productoId)) {
      listaGlobal.remove(productoId);
      notifyListeners();
      await updateListaFirebase();
    }
  }

  //Cargar la lista desde Firebase
  void getListaFirebase() async {
    DocumentSnapshot snapshot =
        await bd.collection(collectionId).doc(documentId).get();

    if (snapshot.exists) {
      listaGlobal = List<int>.from(snapshot['productos']);
      notifyListeners();
    }
  }

  //Guardar la lista en Firebase
  Future<void> updateListaFirebase() async {
    await bd
        .collection(collectionId)
        .doc(documentId)
        .set({"productos": listaGlobal});
  }
}
