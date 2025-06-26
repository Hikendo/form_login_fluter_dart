import 'package:flutter/material.dart';
import 'package:mi_app/services/orden_compra_service.dart';
import 'package:mi_app/views/ordenes/orden_compra_detail_page.dart';

class OrdenCompraListPage extends StatefulWidget {
  @override
  _OrdenCompraListPageState createState() => _OrdenCompraListPageState();
}

class _OrdenCompraListPageState extends State<OrdenCompraListPage> {
  List ordenes = [];
  bool isLoading = true;
  String? errorMessage;
  String query = '';
  int currentPage = 1;

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cargarOrdenes();
  }

  void cargarOrdenes() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final result = await OrdenCompraService().fetchOrdenesCompra(query: query);

    if (result['success']) {
      setState(() {
        ordenes = result['items']['data'] ?? [];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
        errorMessage = result['message'] ?? 'Error al obtener los datos.';
      });
    }
  }

  void buscarOrdenes() {
    setState(() {
      query = searchController.text.trim();
      currentPage = 1;
    });
    cargarOrdenes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Órdenes de Compra'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: TextField(
              controller: searchController,
              onSubmitted: (_) => buscarOrdenes(),
              decoration: InputDecoration(
                hintText: 'Buscar por referencia o factura',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: buscarOrdenes,
                ),
              ),
            ),
          ),
        ),
      ),
      body: isLoading
          ? _buildLoading()
          : errorMessage != null
          ? _buildError()
          : ordenes.isEmpty
          ? _buildEmpty()
          : _buildListView(),
    );
  }

  Widget _buildLoading() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CircularProgressIndicator(),
        SizedBox(height: 12),
        Text('Cargando órdenes de compra...'),
      ],
    ),
  );

  Widget _buildError() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error_outline, color: Colors.red, size: 48),
        SizedBox(height: 12),
        Text(
          errorMessage!,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
        SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: cargarOrdenes,
          icon: Icon(Icons.refresh),
          label: Text('Reintentar'),
        ),
      ],
    ),
  );

  Widget _buildEmpty() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.inbox, size: 48, color: Colors.grey),
        SizedBox(height: 12),
        Text(
          'No hay órdenes de compra registradas',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    ),
  );

  Widget _buildListView() => ListView.builder(
    itemCount: ordenes.length,
    itemBuilder: (context, index) {
      final orden = ordenes[index];
      return Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          title: Text(
            'OC ${orden['orden_compra_ref'] ?? '---'}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4),
              Text('Proveedor: ${orden['proveedor']?['nombre'] ?? '---'}'),
              Text('Entrega: ${orden['fecha_promesa_entrega'] ?? '-'}'),
              Text('Factura: ${orden['factura'] ?? 'Sin registrar'}'),
              Text(
                'Total: ${orden['importe_total'] ?? '0.00'} ${orden['moneda'] ?? ''}',
              ),
              Text('Estado: ${orden['status'] ?? 'Sin estado'}'),
            ],
          ),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => OrdenCompraDetailPage(ordenId: orden['id']),
              ),
            );
          },
        ),
      );
    },
  );
}
