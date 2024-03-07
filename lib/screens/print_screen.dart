import 'package:flutter/material.dart';
import 'Sign_in_out/sign_in_screen.dart';

class PrintScreen extends StatelessWidget {
  const PrintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: const Text('Perfusion Sheet'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Today\'s Date: ${DateTime.now().toLocal()}',
              style: const TextStyle(fontSize: 28),
            ),
            // Create a function to create a card
          ],
        ),
      ),
    );
  }
}
