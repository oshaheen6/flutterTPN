import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/context/auth_provider.dart';
import 'sign_in_screen.dart';

class PrintScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
// Get the AuthProvider instance from the provider
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: const Text('Perfusion Sheet'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                // Sign out the user and navigate to the sign in screen
                authProvider.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
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
