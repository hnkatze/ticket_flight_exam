import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/ticket_avion_model.dart';

class TicketAvionProvider with ChangeNotifier {
  final CollectionReference _ticketCollection =
      FirebaseFirestore.instance.collection('TicketAvion');

  List<TicketAvion> _tickets = [];
  List<TicketAvion> get tickets => _tickets;

  // Obtener todos los tickets
  Future<void> fetchTickets() async {
    try {
      QuerySnapshot snapshot = await _ticketCollection.get();
      _tickets = snapshot.docs.map((doc) {
        return TicketAvion.fromFirestore(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      notifyListeners();
    } catch (e) {
      print("Error al obtener los tickets: $e");
    }
  }

  // Crear un nuevo ticket
  Future<void> addTicket(TicketAvion ticket) async {
    try {
      DocumentReference docRef =
          await _ticketCollection.add(ticket.toFirestore());
      ticket.id = docRef.id; // Asignar el ID generado por Firestore
      _tickets.add(ticket);
      notifyListeners();
    } catch (e) {
      print("Error al agregar el ticket: $e");
    }
  }

  // Actualizar un ticket existente
  Future<void> updateTicket(TicketAvion ticket) async {
    try {
      await _ticketCollection.doc(ticket.id).update(ticket.toFirestore());
      int index = _tickets.indexWhere((t) => t.id == ticket.id);
      if (index != -1) {
        _tickets[index] = ticket;
        notifyListeners();
      }
    } catch (e) {
      print("Error al actualizar el ticket: $e");
    }
  }

  Future<void> deleteTicket(String ticketId) async {
    try {
      await _ticketCollection.doc(ticketId).delete();
      _tickets.removeWhere((ticket) => ticket.id == ticketId);
      notifyListeners();
    } catch (e) {
      print("Error al eliminar el ticket: $e");
    }
  }

  Future<TicketAvion> getTicketById(String ticketId) async {
    try {
      DocumentSnapshot doc = await _ticketCollection.doc(ticketId).get();
      return TicketAvion.fromFirestore(
          doc.data() as Map<String, dynamic>, doc.id);
    } catch (e) {
      print("Error al obtener el ticket por ID: $e");
      return TicketAvion(
        id: '',
        numeroVuelo: '',
        aerolinea: '',
        nombrePasajero: '',
        origen: '',
        destino: '',
        asiento: '',
        clase: '',
      );
    }
  }

  void clearTickets() {
    _tickets.clear();
  }
}
