import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/add_ticket_screen.dart';
import 'screens/tocket_avion_screen.dart';
import 'services/tocket_avion_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const TicketAvionScreen(),
      ),
      GoRoute(
        path: '/add-ticket',
        name: 'addTicket',
        builder: (context, state) => const AddTicketScreen(),
      ),
      GoRoute(
        path: '/edit-ticket/:id',
        name: 'editTicket',
        builder: (context, state) {
          final String ticketId = state.pathParameters['id']!;
          return EditTicketScreen(ticketId: ticketId);
        },
      ),
      GoRoute(
        path: '/ticket-detail/:id',
        name: 'ticketDetail',
        builder: (context, state) {
          final String ticketId = state.pathParameters['id']!;
          return TicketDetailScreen(ticketId: ticketId);
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TicketAvionProvider()),
        ],
        child: MaterialApp.router(
          routerConfig: _router,
          title: 'Ticket Management App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
        ));
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tickets List')),
      body: const Center(child: Text('List of Tickets')),
    );
  }
}

// class AddTicketScreen extends StatelessWidget {
//   const AddTicketScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Add Ticket')),
//       body: const Center(child: Text('Form to Add a Ticket')),
//     );
//   }
// }

class EditTicketScreen extends StatelessWidget {
  final String ticketId;
  const EditTicketScreen({super.key, required this.ticketId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Ticket')),
      body: Center(child: Text('Editing Ticket ID: $ticketId')),
    );
  }
}

class TicketDetailScreen extends StatelessWidget {
  final String ticketId;
  const TicketDetailScreen({super.key, required this.ticketId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ticket Details')),
      body: Center(child: Text('Details of Ticket ID: $ticketId')),
    );
  }
}
