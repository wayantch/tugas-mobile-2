import 'package:flutter/material.dart';
import 'package:sweetique/core/components/navigation/navigation.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Kategori')),
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 1));
  }
}
