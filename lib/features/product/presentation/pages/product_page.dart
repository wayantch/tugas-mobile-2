import 'package:flutter/material.dart';
import 'package:sweetique/core/components/navigation/navigation.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('produk')),
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 3));
  }
}
