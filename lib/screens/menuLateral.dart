import 'package:flutter/material.dart';
import '../routes/routes.dart';

//Drawer navegable accesible desde cualquier pantalla de la app
class MenuLateral extends StatelessWidget {
  const MenuLateral({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4CAF50), Color(0xFF388E3C)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          children: <Widget>[
            //Título desarrollador y foto
            const UserAccountsDrawerHeader(
              accountName: Text(
                "La lista de la compra",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                "Hecho por Pablo Aguilera",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/logo2.png"),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            //Botón que abre la pantalla de productos
            ListTile(
              leading: const Icon(Icons.category, color: Colors.white),
              title: const Text(
                "Productos",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, AppRoutes.productos);
              },
            ),
            const Divider(color: Colors.white54),
            //Botón que abre la pantalla de lista
            ListTile(
              leading: const Icon(Icons.shopping_cart, color: Colors.white),
              title: const Text(
                "Lista",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, AppRoutes.lista);
              },
            ),
            const Divider(color: Colors.white54),
            //Botón que abre la pantalla de créditos
            ListTile(
              leading: const Icon(Icons.list_alt_rounded, color: Colors.white),
              title: const Text(
                "Créditos",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, AppRoutes.creditos);
              },
            ),
            const Divider(color: Colors.white54),
          ],
        ),
      ),
    );
  }
}
