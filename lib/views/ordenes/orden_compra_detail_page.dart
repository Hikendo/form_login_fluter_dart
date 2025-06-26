import 'package:flutter/material.dart';
import 'package:mi_app/services/orden_compra_service.dart';

class OrdenCompraDetailPage extends StatefulWidget {
  final int ordenId;

  OrdenCompraDetailPage({required this.ordenId});

  @override
  _OrdenCompraDetailPageState createState() => _OrdenCompraDetailPageState();
}

class _OrdenCompraDetailPageState extends State<OrdenCompraDetailPage> {
  Map? orden;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    cargarDetalle();
  }

  void cargarDetalle() async {
    final servicio = OrdenCompraService();
    final result = await servicio.fetchOrdenCompraById(widget.ordenId);

    if (result['success']) {
      setState(() {
        orden = result['item'];
        isLoading = false;
      });
    } else {
      // handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalle Orden #${widget.ordenId}')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : orden == null
          ? Center(child: Text('Orden no encontrada'))
          : ListView(
              padding: EdgeInsets.all(16),
              children: [
                Text(
                  'Proveedor: ${orden!['proveedor']['nombre']}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 12),
                Text('Productos:', style: TextStyle(fontSize: 16)),
                ...List.generate(orden!['productos'].length, (index) {
                  final producto = orden!['productos'][index];
                  return ListTile(
                    title: Text(producto['producto']['nombre']),
                    subtitle: Text('Cantidad: ${producto['cantidad']}'),
                    trailing: Text('\$${producto['importe']}'),
                  );
                }),
              ],
            ),
    );
  }
}
