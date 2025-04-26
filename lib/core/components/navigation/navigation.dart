import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sweetique/core/constant/url_app_constant.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;

  const CustomBottomNavBar({Key? key, required this.selectedIndex})
    : super(key: key);

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(UrlAppConstant.home); // Home
        break;
      case 1:
        context.go(UrlAppConstant.category); // Categories
        break;
      case 2:
        context.go(UrlAppConstant.cart); // Cart
        break;
      case 3:
        context.go(UrlAppConstant.product); // Orders
        break;
      case 4:
        context.go(UrlAppConstant.profile); // Profile
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: selectedIndex,
      onTap: (index) => _onItemTapped(context, index),
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: [
        _buildNavItem(Icons.home, 'Beranda', 0),
        _buildNavItem(Icons.category, 'Kategori', 1),
        _buildNavItem(Icons.shopping_cart, 'Keranjang', 2),
        _buildNavItem(Icons.production_quantity_limits_outlined, 'Produk', 3),
        _buildNavItem(Icons.person, 'Profil', 4),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem(
    IconData icon,
    String label,
    int index,
  ) {
    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: selectedIndex == index ? Color(0xFF374D7F) : Colors.grey,
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selectedIndex == index ? Color(0xFF374D7F) : Colors.grey,
              fontSize: 12,
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w600,
              letterSpacing: 0.11,
            ),
          ),
        ],
      ),
      label: '',
    );
  }
}
