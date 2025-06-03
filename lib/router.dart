import 'package:go_router/go_router.dart';

import 'screens/home_screen.dart';
import 'screens/product_form_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/product',
      builder: (context, state) => const ProductFormScreen(),
    ),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ProductFormScreen(productId: id);
      },
    ),
  ],
);