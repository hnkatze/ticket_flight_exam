import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/ticket_avion_model.dart';
import '../components/app_bar_compo.dart';
import '../services/tocket_avion_provider.dart';

class TicketEditScreen extends StatefulWidget {
  final String ticketId;

  const TicketEditScreen({super.key, required this.ticketId});

  @override
  // ignore: library_private_types_in_public_api
  _TicketEditScreenState createState() => _TicketEditScreenState();
}

class _TicketEditScreenState extends State<TicketEditScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _numeroVueloController;
  late TextEditingController _aerolineaController;
  late TextEditingController _nombrePasajeroController;
  late TextEditingController _origenController;
  late TextEditingController _destinoController;
  late TextEditingController _asientoController;
  late TextEditingController _claseController;

  @override
  void initState() {
    super.initState();

    _numeroVueloController = TextEditingController();
    _aerolineaController = TextEditingController();
    _nombrePasajeroController = TextEditingController();
    _origenController = TextEditingController();
    _destinoController = TextEditingController();
    _asientoController = TextEditingController();
    _claseController = TextEditingController();

    final ticketProvider =
        Provider.of<TicketAvionProvider>(context, listen: false);
    ticketProvider.getTicketById(widget.ticketId).then((ticket) {
      _numeroVueloController.text = ticket.numeroVuelo;
      _aerolineaController.text = ticket.aerolinea;
      _nombrePasajeroController.text = ticket.nombrePasajero;
      _origenController.text = ticket.origen;
      _destinoController.text = ticket.destino;
      _asientoController.text = ticket.asiento;
      _claseController.text = ticket.clase;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _numeroVueloController.dispose();
    _aerolineaController.dispose();
    _nombrePasajeroController.dispose();
    _origenController.dispose();
    _destinoController.dispose();
    _asientoController.dispose();
    _claseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Editar Ticket"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _numeroVueloController,
                decoration: const InputDecoration(labelText: 'Número de Vuelo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el número de vuelo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _aerolineaController,
                decoration: const InputDecoration(labelText: 'Aerolínea'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la aerolínea';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nombrePasajeroController,
                decoration:
                    const InputDecoration(labelText: 'Nombre del Pasajero'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre del pasajero';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _origenController,
                decoration: const InputDecoration(labelText: 'Origen'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el origen';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _destinoController,
                decoration: const InputDecoration(labelText: 'Destino'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el destino';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _asientoController,
                decoration: const InputDecoration(labelText: 'Asiento'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el asiento';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _claseController,
                decoration: const InputDecoration(labelText: 'Clase'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la clase';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final updatedTicket = TicketAvion(
                      id: widget.ticketId,
                      numeroVuelo: _numeroVueloController.text,
                      aerolinea: _aerolineaController.text,
                      nombrePasajero: _nombrePasajeroController.text,
                      origen: _origenController.text,
                      destino: _destinoController.text,
                      asiento: _asientoController.text,
                      clase: _claseController.text,
                    );
                    final ticketProvider = Provider.of<TicketAvionProvider>(
                        context,
                        listen: false);
                    ticketProvider.updateTicket(updatedTicket);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Ticket actualizado exitosamente')),
                    );
                    context.goNamed('home');
                  }
                },
                child: const Text('Guardar Cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
