import 'package:flutter/material.dart';

import 'widget/product_card.dart';
import 'widget/cart_summary_page.dart';
import 'blocs/cart_cubit.dart';
import 'models/produk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UTS Mobile Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CartCubit cart = CartCubit();

  // sample products
  final List<Produk> products = const [
    Produk(id: 'p1', nama: 'Kopi Tubruk', price: 15000, image: ''),
    Produk(id: 'p2', nama: 'Teh Manis', price: 8000, image: ''),
    Produk(id: 'p3', nama: 'Roti Bakar', price: 12000, image: ''),
  ];

  @override
  void dispose() {
    cart.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produk'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CartSummaryPage(cart: cart)),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final p = products[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: ProductCard(
              produk: p,
              cart: cart,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CartSummaryPage(cart: cart)),
        ),
        icon: const Icon(Icons.shopping_cart_checkout),
        label: const Text('Cart'),
      ),
    );
  }
}
