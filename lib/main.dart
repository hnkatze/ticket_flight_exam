import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/add_ticket_screen.dart';
import 'screens/ticket_details_screen.dart';
import 'screens/ticket_edit_screen.dart';
import 'screens/ticket_avion_screen.dart';
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
          return TicketEditScreen(ticketId: ticketId);
        },
      ),
      GoRoute(
        path: '/ticket-detail/:id',
        name: 'ticketDetail',
        builder: (context, state) {
          final String ticketId = state.pathParameters['id']!;
          return TicketDetailScreen(
            id: ticketId,
          );
        },
      ),
    ],
  );

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TicketAvionProvider()),
        ],
        child: MaterialApp.router(
          routerConfig: _router,
          title: 'Ticket Management App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
        ));
  }
}
