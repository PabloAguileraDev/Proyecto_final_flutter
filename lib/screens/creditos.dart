import 'package:flutter/material.dart';
import 'package:proyecto_final_flutter/screens/menuLateral.dart';

class Creditos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créditos'),
        backgroundColor: Colors.green,
      ),
      drawer: MenuLateral(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Icon(Icons.shopping_cart, size: 80, color: Colors.green),
                  SizedBox(height: 10),
                  Text(
                    'La Lista de la Compra',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Versión 1.0.0',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Desarrollado por:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text('• Pablo Aguilera - UI/UX Designer'),
            Text('• Pablo Aguilera - Application Developer'),
            SizedBox(height: 20),
            Text(
              'Agradecimientos especiales:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text('• Mi profesor por compartir su amplio conocimiento'),
            Text(
                '• Mis compañeros, especialmente Óscar Luque y Pedro Vigara por ayudarme con los problemas que me surgen'),
            Text('• Los futuros usuarios que confían en mí'),
            Spacer(),
            Center(
              child: Text(
                '© 2025 La Lista de la Compra. All rights reserved.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
