import 'package:flutter/material.dart'; // Importa el paquete principal de Flutter.
import 'package:mi_app/interfaces/OrdenCompraModel.dart';
import 'package:mi_app/services/orden_compra_service.dart'; // Importa el servicio para obtener órdenes de compra.
import 'package:mi_app/views/ordenes/orden_compra_detail_page.dart'; // Importa la página de detalle de orden de compra.

class OrdenCompraListPage extends StatefulWidget {
  // Widget de estado para mostrar la lista de órdenes.
  @override
  _OrdenCompraListPageState createState() => _OrdenCompraListPageState(); // Crea el estado asociado.
}

class _OrdenCompraListPageState extends State<OrdenCompraListPage> {
  // Estado de la página de lista.
  List<OrdenCompraModel> ordenes = []; // Lista de órdenes de compra tipada.
  bool isLoading = true; // Indica si se están cargando los datos.
  String? errorMessage; // Mensaje de error si ocurre alguno.
  String query = ''; // Texto de búsqueda.
  int currentPage = 1; // Página actual (para paginación si se implementa).

  final TextEditingController searchController =
      TextEditingController(); // Controlador para el campo de búsqueda.

  @override
  void initState() {
    // Método que se ejecuta al iniciar el widget.
    super.initState();
    cargarOrdenes(); // Carga las órdenes al iniciar.
  }

  void cargarOrdenes() async {
    // Método para cargar las órdenes desde el servicio.
    setState(() {
      isLoading = true; // Muestra indicador de carga.
      errorMessage = null; // Limpia mensaje de error.
    });

    final result = await OrdenCompraService().fetchOrdenesCompra(
      query: query,
    ); // Llama al servicio para obtener órdenes.

    if (result['success']) {
      setState(() {
        ordenes = List<OrdenCompraModel>.from(
          result['items'],
        ); // Tipado correcto
        isLoading = false;
      });
      // Imprime los datos de cada orden en consola
      for (var orden in ordenes) {
        print(
          orden,
        ); // Asegúrate de tener implementado toString() en OrdenCompraModel
      }
    } else {
      // Si ocurre un error...
      setState(() {
        isLoading = false; // Oculta indicador de carga.
        errorMessage =
            result['message'] ??
            'Error al obtener los datos.'; // Muestra mensaje de error.
      });
    }
  }

  void buscarOrdenes() {
    // Método para buscar órdenes según el texto ingresado.
    setState(() {
      query = searchController.text.trim(); // Actualiza el texto de búsqueda.
      currentPage = 1; // Reinicia la página actual.
    });
    cargarOrdenes(); // Vuelve a cargar las órdenes filtradas.
  }

  @override
  Widget build(BuildContext context) {
    // Construye la interfaz de usuario.
    return Scaffold(
      appBar: AppBar(
        // Barra superior de la app.
        title: Text('Órdenes de Compra'), // Título de la pantalla.
        bottom: PreferredSize(
          // Widget para agregar un campo de búsqueda debajo del AppBar.
          preferredSize: Size.fromHeight(60), // Altura preferida.
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 6,
            ), // Espaciado alrededor del campo.
            child: TextField(
              controller:
                  searchController, // Controlador del campo de búsqueda.
              onSubmitted: (_) =>
                  buscarOrdenes(), // Ejecuta búsqueda al presionar Enter.
              decoration: InputDecoration(
                hintText: 'Buscar por referencia o factura', // Texto de ayuda.
                suffixIcon: IconButton(
                  icon: Icon(Icons.search), // Icono de búsqueda.
                  onPressed:
                      buscarOrdenes, // Ejecuta búsqueda al presionar el icono.
                ),
              ),
            ),
          ),
        ),
      ),
      body:
          isLoading // El cuerpo de la pantalla depende del estado de carga y los datos.
          ? _buildLoading() // Muestra indicador de carga.
          : errorMessage !=
                null // Si hay error...
          ? _buildError() // Muestra mensaje de error.
          : ordenes
                .isEmpty // Si la lista está vacía...
          ? _buildEmpty() // Muestra mensaje de lista vacía.
          : _buildListView(), // Si hay datos, muestra la lista.
    );
  }

  Widget _buildLoading() => Center(
    // Widget para mostrar mientras se cargan los datos.
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CircularProgressIndicator(), // Indicador de progreso circular.
        SizedBox(height: 12), // Espacio vertical.
        Text('Cargando órdenes de compra...'), // Mensaje de carga.
      ],
    ),
  );

  Widget _buildError() => Center(
    // Widget para mostrar si ocurre un error.
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 48,
        ), // Icono de error.
        SizedBox(height: 12),
        Text(
          errorMessage!, // Mensaje de error.
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
        SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: cargarOrdenes, // Botón para reintentar la carga.
          icon: Icon(Icons.refresh),
          label: Text('Reintentar'),
        ),
      ],
    ),
  );

  Widget _buildEmpty() => Center(
    // Widget para mostrar si no hay órdenes.
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          Icons.inbox,
          size: 48,
          color: Colors.grey,
        ), // Icono de bandeja vacía.
        SizedBox(height: 12),
        Text(
          'No hay órdenes de compra registradas', // Mensaje de lista vacía.
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    ),
  );

  Widget _buildListView() => ListView.builder(
    // Widget para mostrar la lista de órdenes.
    itemCount: ordenes.length, // Número de elementos en la lista.
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
            'OC ${orden.ordenCompraRef}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4),
              Text('Proveedor: ${orden.proveedor.nombreRazonSocial}'),
              Text('Entrega: ${orden.fechaPromesaEntrega ?? '-'}'),
              Text('Factura: ${orden.factura ?? 'Sin registrar'}'),
              Text('Total: ${orden.importeTotal} ${orden.moneda}'),
              Text('Estado: ${orden.status ?? 'Sin estado'}'),
            ],
          ),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => OrdenCompraDetailPage(ordenId: orden.id),
              ),
            );
          },
        ),
      );
    },
  );
}
// Este widget representa una lista de órdenes de compra.
// Permite buscar órdenes, muestra un indicador de carga, maneja errores y muestra detalles de
// cada orden al tocar una tarjeta.
// Utiliza un servicio para obtener los datos y los muestra en una lista con tarjetas.
// Además, maneja estados de carga, error y vacío de manera adecuada.