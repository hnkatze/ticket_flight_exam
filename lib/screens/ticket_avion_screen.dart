import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../components/app_bar_compo.dart';
import '../services/tocket_avion_provider.dart';

class TicketAvionScreen extends StatefulWidget {
  const TicketAvionScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TicketAvionScreenState createState() => _TicketAvionScreenState();
}

class _TicketAvionScreenState extends State<TicketAvionScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TicketAvionProvider>(context, listen: false).clearTickets();
    Provider.of<TicketAvionProvider>(context, listen: false).fetchTickets();
  }

  @override
  Widget build(BuildContext context) {
    final ticketProvider = Provider.of<TicketAvionProvider>(context);

    return Scaffold(
      appBar: const CustomAppBar(title: "Tickets De Avión"),
      body: ticketProvider.tickets.isEmpty
          ? const Center(child: Text('No hay tickets disponibles'))
          : ListView.builder(
              itemCount: ticketProvider.tickets.length,
              itemBuilder: (context, index) {
                final ticket = ticketProvider.tickets[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    onTap: () => context.goNamed('ticketDetail',
                        pathParameters: {'id': ticket.id}),
                    contentPadding: const EdgeInsets.all(10),
                    leading: const CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.flight, color: Colors.white),
                    ),
                    title: Text(
                      ticket.numeroVuelo,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      '${ticket.aerolinea} - ${ticket.nombrePasajero}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          onPressed: () {
                            context.goNamed('editTicket',
                                pathParameters: {'id': ticket.id});
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text('Confirmar'),
                                content: const Text(
                                    '¿Estás seguro de eliminar este ticket?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(ctx).pop(),
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      ticketProvider.deleteTicket(ticket.id);
                                      Navigator.of(ctx).pop();
                                    },
                                    child: const Text('Eliminar'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ticketProvider.clearTickets();
          context.goNamed(
            'addTicket',
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
