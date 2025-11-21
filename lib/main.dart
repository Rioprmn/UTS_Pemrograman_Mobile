import 'package:flutter/material.dart';

import 'pages/cart_home_page.dart';
import 'blocs/cart_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final CartCubit cart;

  @override
  void initState() {
    super.initState();
    cart = CartCubit();
  }

  @override
  void dispose() {
    cart.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UTS Mobile Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CartHomePage(cart: cart),
    );
  }
}
