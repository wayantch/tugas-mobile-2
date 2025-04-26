import 'package:go_router/go_router.dart';
import 'package:sweetique/core/constant/menu_constant.dart';
import 'package:sweetique/core/constant/url_app_constant.dart';
import 'package:sweetique/features/auth/presentation/pages/login_or_register_page.dart';
import 'package:sweetique/features/auth/presentation/pages/login_page.dart';
import 'package:sweetique/features/auth/presentation/pages/register_page.dart';
import 'package:sweetique/features/cart/presentation/pages/cart_page.dart';
import 'package:sweetique/features/category/presentation/pages/category_page.dart';
import 'package:sweetique/features/favorite/presentation/pages/favorite_page.dart';
import 'package:sweetique/features/home/presentation/pages/home_page.dart';
import 'package:sweetique/features/product/presentation/pages/product_page.dart';
import 'package:sweetique/features/profile/presentation/pages/profile_page.dart';

class MyRouter {
  final GoRouter router = GoRouter(
    initialLocation: UrlAppConstant.loginOrRegister,
    routes: [
      GoRoute(
        path: UrlAppConstant.loginOrRegister,
        name: MenuConstants.loginOrRegister,
        builder: (context, state) => const LoginOrRegisterPage(),
      ),
      GoRoute(
        path: UrlAppConstant.login,
        name: MenuConstants.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: UrlAppConstant.register,
        name: MenuConstants.register,
        builder: (context, state) => RegisterPage(),
      ),
      GoRoute(
        path: UrlAppConstant.home,
        name: MenuConstants.home,
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: UrlAppConstant.favorite,
        name: MenuConstants.favorite,
        builder: (context, state) => FavoritePage(),
      ),
      GoRoute(
        path: UrlAppConstant.category,
        name: MenuConstants.category,
        builder: (context, state) => CategoryPage(),
      ),
      GoRoute(
        path: UrlAppConstant.cart,
        name: MenuConstants.cart,
        builder: (context, state) => CartPage(),
      ),
      GoRoute(
        path: UrlAppConstant.product,
        name: MenuConstants.product,
        builder: (context, state) => ProductPage(),
      ),
      GoRoute(
        path: UrlAppConstant.profile,
        name: MenuConstants.profile,
        builder: (context, state) => ProfilePage(),
      ),
    ],
  );
}
