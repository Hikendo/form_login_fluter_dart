import 'package:flutter/material.dart';

class OrdenesCompraScreen extends StatelessWidget {
  const OrdenesCompraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Órdenes de Compra')),
      body: const Center(child: Text('Aquí va la lista de órdenes de compra')),
    );
  }
}
