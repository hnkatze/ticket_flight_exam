import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/ticket_avion_model.dart';
import '../services/tocket_avion_provider.dart';

class AddTicketScreen extends StatefulWidget {
  const AddTicketScreen({super.key});

  @override
  _AddTicketScreenState createState() => _AddTicketScreenState();
}

class _AddTicketScreenState extends State<AddTicketScreen> {
  final _formKey = GlobalKey<FormState>();

  final _numeroVueloController = TextEditingController();
  final _aerolineaController = TextEditingController();
  final _nombrePasajeroController = TextEditingController();
  final _origenController = TextEditingController();
  final _destinoController = TextEditingController();
  final _asientoController = TextEditingController();
  final _claseController = TextEditingController();

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
      appBar: AppBar(
        title: const Text('Add Ticket'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _numeroVueloController,
                decoration: const InputDecoration(labelText: 'Número de Vuelo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un número de vuelo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _aerolineaController,
                decoration: const InputDecoration(labelText: 'Aerolínea'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa una aerolínea';
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
                    return 'Por favor ingresa el nombre del pasajero';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _origenController,
                decoration: const InputDecoration(labelText: 'Origen'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el origen';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _destinoController,
                decoration: const InputDecoration(labelText: 'Destino'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el destino';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _asientoController,
                decoration: const InputDecoration(labelText: 'Asiento'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el asiento';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _claseController,
                decoration: const InputDecoration(labelText: 'Clase'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la clase';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    var newTicket = TicketAvion(
                      id: const Uuid().v4(),
                      numeroVuelo: _numeroVueloController.text,
                      aerolinea: _aerolineaController.text,
                      nombrePasajero: _nombrePasajeroController.text,
                      origen: _origenController.text,
                      destino: _destinoController.text,
                      asiento: _asientoController.text,
                      clase: _claseController.text,
                    );

                    Provider.of<TicketAvionProvider>(context, listen: false)
                        .addTicket(newTicket);

                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Agregar Ticket'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
