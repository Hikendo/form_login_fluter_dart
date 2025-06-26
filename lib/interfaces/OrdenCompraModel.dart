class OrdenCompraModel {
  final int id;
  final String ordenCompraRef;
  final int proveedorId;
  final String? fechaPromesaEntrega;
  final String? fechaRecepcion;
  final String factura;
  final String importeNeto;
  final String otrosCostos;
  final String importeTotal;
  final String moneda;
  final String? direccionEntrega;
  final int almacenId;
  final String observaciones;
  final int userId;
  final String? incoterm;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Proveedor proveedor;
  final Usuario user;
  final List<DetalleOrdenCompra> detalleOrdenesCompra;

  OrdenCompraModel({
    required this.id,
    required this.ordenCompraRef,
    required this.proveedorId,
    required this.fechaPromesaEntrega,
    required this.fechaRecepcion,
    required this.factura,
    required this.importeNeto,
    required this.otrosCostos,
    required this.importeTotal,
    required this.moneda,
    required this.direccionEntrega,
    required this.almacenId,
    required this.observaciones,
    required this.userId,
    required this.incoterm,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.proveedor,
    required this.user,
    required this.detalleOrdenesCompra,
  });

  factory OrdenCompraModel.fromJson(Map<String, dynamic> json) {
    return OrdenCompraModel(
      id: json['id'],
      ordenCompraRef: json['orden_compra_ref'],
      proveedorId: json['proveedor_id'],
      fechaPromesaEntrega: json['fecha_promesa_entrega'],
      fechaRecepcion: json['fecha_recepcion'],
      factura: json['factura'],
      importeNeto: json['importe_neto'],
      otrosCostos: json['otros_costos'],
      importeTotal: json['importe_total'],
      moneda: json['moneda'],
      direccionEntrega: json['direccion_entrega'],
      almacenId: json['almacen_id'],
      observaciones: json['observaciones'],
      userId: json['user_id'],
      incoterm: json['incoterm'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      proveedor: Proveedor.fromJson(json['proveedor']),
      user: Usuario.fromJson(json['user']),
      detalleOrdenesCompra: (json['detalle_ordenes_compra'] as List)
          .map((e) => DetalleOrdenCompra.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orden_compra_ref': ordenCompraRef,
      'proveedor_id': proveedorId,
      'fecha_promesa_entrega': fechaPromesaEntrega,
      'fecha_recepcion': fechaRecepcion,
      'factura': factura,
      'importe_neto': importeNeto,
      'otros_costos': otrosCostos,
      'importe_total': importeTotal,
      'moneda': moneda,
      'direccion_entrega': direccionEntrega,
      'almacen_id': almacenId,
      'observaciones': observaciones,
      'user_id': userId,
      'incoterm': incoterm,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'proveedor': proveedor.toJson(),
      'user': user.toJson(),
      'detalle_ordenes_compra': detalleOrdenesCompra
          .map((e) => e.toJson())
          .toList(),
    };
  }
}

class Proveedor {
  final int id;
  final String nombreRazonSocial;
  final String direccion;
  final int paisId;
  final String contacto;
  final String telefono;
  final String email;
  final String rfc;
  final int diasCredito;
  final String? logo;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Proveedor({
    required this.id,
    required this.nombreRazonSocial,
    required this.direccion,
    required this.paisId,
    required this.contacto,
    required this.telefono,
    required this.email,
    required this.rfc,
    required this.diasCredito,
    required this.logo,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Proveedor.fromJson(Map<String, dynamic> json) {
    return Proveedor(
      id: json['id'],
      nombreRazonSocial: json['nombre_razonSocial'],
      direccion: json['direccion'],
      paisId: json['pais_id'],
      contacto: json['contacto'],
      telefono: json['telefono'],
      email: json['email'],
      rfc: json['rfc'],
      diasCredito: json['dias_credito'],
      logo: json['logo'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre_razonSocial': nombreRazonSocial,
    'direccion': direccion,
    'pais_id': paisId,
    'contacto': contacto,
    'telefono': telefono,
    'email': email,
    'rfc': rfc,
    'dias_credito': diasCredito,
    'logo': logo,
    'status': status,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}

class Usuario {
  final int id;
  final String name;
  final String email;
  final String? emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  Usuario({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'email_verified_at': emailVerifiedAt,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}

class DetalleOrdenCompra {
  final int id;
  final String ordenCompraId;
  final int proveedorId;
  final int productoId;
  final int cantidad;
  final String precioUnidad;
  final String importe;
  final String? observaciones;
  final DateTime createdAt;
  final DateTime updatedAt;

  DetalleOrdenCompra({
    required this.id,
    required this.ordenCompraId,
    required this.proveedorId,
    required this.productoId,
    required this.cantidad,
    required this.precioUnidad,
    required this.importe,
    required this.observaciones,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DetalleOrdenCompra.fromJson(Map<String, dynamic> json) {
    return DetalleOrdenCompra(
      id: json['id'],
      ordenCompraId: json['orden_compra_id'],
      proveedorId: json['proveedor_id'],
      productoId: json['producto_id'],
      cantidad: json['cantidad'],
      precioUnidad: json['precio_unidad'],
      importe: json['importe'],
      observaciones: json['observaciones'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'orden_compra_id': ordenCompraId,
    'proveedor_id': proveedorId,
    'producto_id': productoId,
    'cantidad': cantidad,
    'precio_unidad': precioUnidad,
    'importe': importe,
    'observaciones': observaciones,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}
