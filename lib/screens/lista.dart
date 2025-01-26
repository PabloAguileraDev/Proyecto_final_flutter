import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final_flutter/screens/listaProductos.dart';
import 'package:proyecto_final_flutter/screens/menuLateral.dart';
import 'package:proyecto_final_flutter/screens/screens.dart';

class Lista extends StatefulWidget {
  const Lista({super.key});

  @override
  State<Lista> createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  final ApiService apiService = ApiService();
  List<dynamic> productos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    cargarProductos();
  }

  //Método para cargar los productos de la lista
  Future<void> cargarProductos() async {
    try {
      final listaGlobal =
          Provider.of<ListaProductos>(context, listen: false).lista;

      List<dynamic> detalles = [];
      for (int id in listaGlobal) {
        final detalle = await apiService.getProductDetails(id);
        detalles.add(detalle);
      }

      setState(() {
        productos = detalles;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  //Método para eliminar producto de la listaç
  void deleteProduct(int id) {
    final listaProductos = Provider.of<ListaProductos>(context, listen: false);
    listaProductos.deleteProduct(id);
    setState(() {
      productos.removeWhere((producto) => producto['id'] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi Lista"),
      ),
      drawer: const MenuLateral(),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : productos.isEmpty
              ? const Center(
                  child: Text(
                    "No hay productos en la lista.",
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  itemCount: productos.length,
                  itemBuilder: (context, index) {
                    final producto = productos[index];
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: ClipRRect(
                          child: Image.network(
                            'https://spoonacular.com/cdn/ingredients_100x100/${producto['image']}',
                            width: 50,
                            height: 50,
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image, size: 50),
                          ),
                        ),
                        title: Text(
                          producto['name'],
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteProduct(producto['id']),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
