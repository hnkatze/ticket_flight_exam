import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ticket_flight_exam/components/app_bar_compo.dart';
import '../models/ticket_avion_model.dart';
import '../services/tocket_avion_provider.dart';

class TicketDetailScreen extends StatelessWidget {
  final String id;

  const TicketDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final ticketProvider =
        Provider.of<TicketAvionProvider>(context, listen: false);

    return Scaffold(
      appBar: const CustomAppBar(title: "Detalles del Ticket"),
      body: FutureBuilder<TicketAvion>(
        future: ticketProvider.getTicketById(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data!.id.isEmpty) {
            // Mostrar modal si no se encuentra el ticket
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showErrorModal(context);
            });
            return const SizedBox();
          }

          final ticket = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ticket.numeroVuelo,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Chip(
                            label: Text(
                              ticket.aerolinea,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: Colors.blueAccent,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            ticket.nombrePasajero,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      const Divider(height: 30, thickness: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.flight_takeoff,
                                    color: Colors.green.shade400,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    ticket.origen,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ],
                              ),
                              Text(
                                'Origen',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.flight_land,
                                    color: Colors.red.shade400,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    ticket.destino,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ],
                              ),
                              Text(
                                'Destino',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(height: 30, thickness: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.event_seat,
                                    color: Colors.purple.shade400,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Asiento: ${ticket.asiento}',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ],
                              ),
                              Text(
                                'Asiento',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                          // Clase
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.class_,
                                    color: Colors.amber.shade400,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Clase: ${ticket.clase}',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ],
                              ),
                              Text(
                                'Clase',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              context.goNamed('editTicket',
                                  pathParameters: {'id': ticket.id});
                            },
                            icon: const Icon(Icons.edit, color: Colors.white),
                            label: const Text('Editar',
                                style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF6309),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              ticketProvider.deleteTicket(ticket.id);
                            },
                            icon: const Icon(Icons.delete, color: Colors.white),
                            label: const Text('Eliminar',
                                style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF0077),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showErrorModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ticket no disponible'),
          content:
              const Text('No pudimos encontrar los detalles de este ticket.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                context.goNamed('home');
              },
              child: const Text('Ir a Inicio'),
            ),
          ],
        );
      },
    );
  }
}
