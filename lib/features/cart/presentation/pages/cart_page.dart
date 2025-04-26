import 'package:flutter/material.dart';
import 'package:sweetique/core/components/navigation/navigation.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Keranjang')),
        bottomNavigationBar: CustomBottomNavBar(selectedIndex: 2),
    );
  }
}
