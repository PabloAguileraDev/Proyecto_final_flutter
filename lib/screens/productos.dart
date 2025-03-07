import 'package:flutter/material.dart';
import 'package:proyecto_final_flutter/screens/detallesProducto.dart';
import 'package:proyecto_final_flutter/services/firebaseService.dart';
import 'package:proyecto_final_flutter/screens/menuLateral.dart';
import 'package:proyecto_final_flutter/services/apiService.dart';
import 'package:provider/provider.dart';

//Clase que contiene los productos obtenidos de la API
//a partir del texto que se introduzca en la barra de búsqueda
class Productos extends StatefulWidget {
  const Productos({super.key});

  @override
  State<Productos> createState() => _ProductosState();
}

class _ProductosState extends State<Productos> {
  final ApiService apiService = ApiService();
  final TextEditingController searchController = TextEditingController();

  List<dynamic> productos = [];
  bool isLoading = false;

  //Método para buscar productos por nombre
  void buscarProductos() async {
    final query = searchController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      isLoading = true;
    });

    try {
      final resultados = await apiService.getProducts(query);
      setState(() {
        productos = resultados;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Se ha producido un error al buscar productos')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  //Método para añadir un producto a la lista
  void agregarALista(int productoId) {
    final listaProductos = Provider.of<ListaProductos>(context, listen: false);
    if (!listaProductos.lista.contains(productoId)) {
      listaProductos.addProduct(productoId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Producto añadido a la lista')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El producto ya está en la lista')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buscar Productos"),
      ),
      drawer: const MenuLateral(),
      body: Column(
        children: [
          //Barra de búsqueda
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Buscar productos...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: buscarProductos,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF4CAF50), width: 2),
                ),
              ),
            ),
          ),
          //Animación de carga
          if (isLoading)
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          else if (productos.isEmpty)
            const Expanded(
              child: Center(
                child: Text(
                  "No hay resultados.",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            )
          else
            //Productos
            Expanded(
              child: ListView.builder(
                  itemCount: productos.length,
                  itemBuilder: (context, index) {
                    final producto = productos[index];
                    return GestureDetector(
                      onTap: () {
                        //Navegar a la pantalla de detalles
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetallesProducto(productoId: producto['id']),
                          ),
                        );
                      },
                      //Tarjeta que contiene cada producto
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: Image.network(
                            'https://spoonacular.com/cdn/ingredients_100x100/${producto['image']}',
                            width: 50,
                            height: 50,
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image, size: 50),
                          ),
                          title: Text(producto['name']),
                          trailing: IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => agregarALista(producto['id']),
                          ),
                        ),
                      ),
                    );
                  }),
            )
        ],
      ),
    );
  }
}
