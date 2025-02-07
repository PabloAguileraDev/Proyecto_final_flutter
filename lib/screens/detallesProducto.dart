import 'package:flutter/material.dart';
import 'package:proyecto_final_flutter/services/apiService.dart';

//Clase que muestra los detalles del prodcto seleccionado
class DetallesProducto extends StatefulWidget {
  final int productoId;

  const DetallesProducto({Key? key, required this.productoId})
      : super(key: key);

  @override
  State<DetallesProducto> createState() => DetallesProductoState();
}

class DetallesProductoState extends State<DetallesProducto> {
  final ApiService apiService = ApiService();
  Map<String, dynamic>? producto;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    cargarDetalles();
  }

  //Método que obtiene los detalles del producto a partir de su id
  Future<void> cargarDetalles() async {
    try {
      final detalles = await apiService.getProductDetails(widget.productoId);
      setState(() {
        producto = detalles;
        isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Se ha producido un error al buscar detalles del producto')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  //Método para obtener un nutriente específico
  String obtenerNutriente(String nombre) {
    if (producto == null || producto!['nutrition'] == null) return "N/A";
    var nutrientes = producto!['nutrition']['nutrients'];
    var nutriente = nutrientes.firstWhere(
      (n) => n['name'] == nombre,
      orElse: () => {"amount": "N/A", "unit": ""},
    );
    return "${nutriente['amount']} ${nutriente['unit']}";
  }

  //Widget para mostrar los nutrientes
  Widget mostrarNutrientes(String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(titulo,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Text(valor, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detalles del Producto")),
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : producto == null
              ? const Center(child: Text("No se encontraron detalles."))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Foto
                        Center(
                          child: Image.network(
                            'https://spoonacular.com/cdn/ingredients_500x500/${producto!['image']}',
                            width: 200,
                            height: 200,
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image, size: 200),
                          ),
                        ),
                        const SizedBox(height: 20),

                        //Nombre
                        Text(
                          producto!['name'] ?? "Nombre no disponible",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),

                        //Categorías
                        if (producto!['categoryPath'] != null)
                          Text(
                            "Categorías: ${producto!['categoryPath'].join(', ')}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        const SizedBox(height: 10),

                        //Precio estimado
                        Text(
                          "Precio: ${producto!['estimatedCost']['value']} ${producto!['estimatedCost']['unit']}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),

                        //Cantidad
                        Text(
                          "Cantidad: ${producto!['amount']} ${producto!['unit']}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),

                        //Consistencia
                        Text(
                          "Consistencia: ${producto!['consistency']}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 20),

                        //Información nutricional
                        const Text(
                          "Información Nutricional:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),

                        mostrarNutrientes(
                            "Calorías", obtenerNutriente("Calories")),
                        mostrarNutrientes("Grasas Saturadas",
                            obtenerNutriente("Saturated Fat")),
                        mostrarNutrientes(
                            "Carbohidratos", obtenerNutriente("Carbohydrates")),
                        mostrarNutrientes(
                            "Proteínas", obtenerNutriente("Protein")),
                        mostrarNutrientes("Azúcar", obtenerNutriente("Sugar")),
                        mostrarNutrientes("Hierro", obtenerNutriente("Iron")),
                        mostrarNutrientes(
                            "Colesterol", obtenerNutriente("Cholesterol")),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
    );
  }
}
