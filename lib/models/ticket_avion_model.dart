class TicketAvion {
  String id;
  String numeroVuelo;
  String aerolinea;
  String nombrePasajero;
  String origen;
  String destino;
  String asiento;
  String clase;

  TicketAvion({
    required this.id,
    required this.numeroVuelo,
    required this.aerolinea,
    required this.nombrePasajero,
    required this.origen,
    required this.destino,
    required this.asiento,
    required this.clase,
  });

  factory TicketAvion.fromFirestore(Map<String, dynamic> data, String id) {
    return TicketAvion(
      id: id,
      numeroVuelo: data['numeroVuelo'] ?? '',
      aerolinea: data['aerolinea'] ?? '',
      nombrePasajero: data['nombrePasajero'] ?? '',
      origen: data['origen'] ?? '',
      destino: data['destino'] ?? '',
      asiento: data['asiento'] ?? '',
      clase: data['clase'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'numeroVuelo': numeroVuelo,
      'aerolinea': aerolinea,
      'nombrePasajero': nombrePasajero,
      'origen': origen,
      'destino': destino,
      'asiento': asiento,
      'clase': clase,
    };
  }
}
