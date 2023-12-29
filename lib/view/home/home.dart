import 'package:flutter/material.dart';
import 'package:local_mining_supplier/constants/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          topMenuBar(context),
        ],
      ),
    );
  }
}
