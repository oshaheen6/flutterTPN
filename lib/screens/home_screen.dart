import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({required Key key}) : super(key: key);

  Widget _buildCard1Content(BuildContext context) {
    return const Column(
      children: <Widget>[
        Text('Card 1'),
        Text('This is the first card.'),
      ],
    );
  }

  Widget _buildCard2Content(BuildContext context) {
    return const Column(
      children: <Widget>[
        Text('Card 2'),
        Text('This is the second card.'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: screenWidth > 600
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.up,
                children: <Widget>[
                  Card(child: Builder(builder: _buildCard1Content)),
                  const SizedBox(width: 16),
                  Card(child: Builder(builder: _buildCard2Content)),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Card(child: Builder(builder: _buildCard1Content)),
                  const SizedBox(height: 16),
                  Card(child: Builder(builder: _buildCard2Content)),
                ],
              ),
      ),
    );
  }
}
