import 'package:flutter/material.dart';

import '../blocs/cart_cubit.dart';
import '../models/product_model.dart';
import '../widget/product_cart.dart';
import 'cart_summary_page.dart';
import 'cart_grid_page.dart';

class CartHomePage extends StatefulWidget {
  final CartCubit cart;

  const CartHomePage({super.key, required this.cart});

  @override
  State<CartHomePage> createState() => _CartHomePageState();
}

class _CartHomePageState extends State<CartHomePage> {
  // sample products — in real app you'd fetch these from a service
  final List<Produk> products = const [
    Produk(id: 'p1', nama: 'Kopi Tubruk', price: 15000, image: ''),
    Produk(id: 'p2', nama: 'Teh Manis', price: 8000, image: ''),
    Produk(id: 'p3', nama: 'Roti Bakar', price: 12000, image: ''),
    Produk(id: 'p4', nama: 'Soto Ayam', price: 20000, image: ''),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products (List)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.grid_view),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CartGridPage(cart: widget.cart, products: products)),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CartSummaryPage(cart: widget.cart)),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final p = products[index];
          return ProductCart(produk: p, cart: widget.cart);
        },
      ),
    );
  }
}
