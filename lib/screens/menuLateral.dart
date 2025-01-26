import 'package:flutter/material.dart';
import '../routes/routes.dart';

class MenuLateral extends StatelessWidget {
  const MenuLateral({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4CAF50), Color(0xFF388E3C)], // Degradado verde
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text(
                "La lista del Mercadona",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                "Hecho por Pablo Aguilera",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/logo.png"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black45, // Oscurece la imagen ligeramente
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
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
          ],
        ),
      ),
    );
  }
}
