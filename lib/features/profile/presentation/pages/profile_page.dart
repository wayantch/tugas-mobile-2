import 'package:flutter/material.dart';
import 'package:sweetique/core/components/navigation/navigation.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Profil'),
        ),
        bottomNavigationBar: CustomBottomNavBar(selectedIndex: 4));
  }
}
