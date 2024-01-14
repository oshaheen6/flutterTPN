import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/context/auth_provider.dart';
import 'patient_selection.dart';
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
            const Row(
              children: [
                Column(
                  child: SizedBox(
                    height: 800,
                    width: 200,
                    child: const buildCards(3),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Create a function to create a card
   Widget buildCards(int numOfCards) {
    List<Widget> cards = [];
    for (int i = 0; i < numO   fCards; i++) {
      cards.add(Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Card #$i'),
              TextField(
                decoration: InputDecoration(hintText: 'Enter text'),
              ),
            ],
          ),
        ),
      ));
    }
    return Column(children: cards);
  }
}