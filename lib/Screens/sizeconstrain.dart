import 'package:flutter/material.dart';

class SizeConstrainExp extends StatelessWidget {
  const SizeConstrainExp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        height: 0,
        width: 0,
      ),
    );
  }
}
