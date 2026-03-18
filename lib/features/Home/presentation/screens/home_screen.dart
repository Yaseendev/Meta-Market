import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.cabin),
        title: Text('Meta Market'),
        centerTitle: false,
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.vaccines)),
        ],
      ),
    );
  }
}
