import 'package:flutter/material.dart';

class SelectScreen extends StatefulWidget {
  @override
  _SelectScreenState createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Example'),
      ),
      body: const Center(
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SelectScreen(),
  ));
}
