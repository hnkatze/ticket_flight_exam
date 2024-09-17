import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ticket_flight_exam/main.dart';
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
    Provider.of<TicketAvionProvider>(context, listen: false).fetchTickets();
  }

  @override
  Widget build(BuildContext context) {
    final ticketProvider = Provider.of<TicketAvionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tickets de Avión'),
      ),
      body: ListView.builder(
        itemCount: ticketProvider.tickets.length,
        itemBuilder: (context, index) {
          final ticket = ticketProvider.tickets[index];
          return ListTile(
            title: Text(ticket.numeroVuelo),
            subtitle: Text('${ticket.aerolinea} - ${ticket.nombrePasajero}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    ticketProvider.deleteTicket(ticket.id);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.goNamed('addTicket'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
