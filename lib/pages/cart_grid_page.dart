import 'package:flutter/material.dart';

import '../blocs/cart_cubit.dart';
import '../models/product_model.dart';
import '../widget/product_cart.dart';
import 'cart_summary_page.dart';

class CartGridPage extends StatelessWidget {
  final CartCubit cart;
  final List<Produk> products;

  const CartGridPage({super.key, required this.cart, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products (Grid)'), actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CartSummaryPage(cart: cart)),
          ),
        )
      ]),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 3 / 4,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final p = products[index];
            return ProductCart(produk: p, cart: cart);
          },
        ),
      ),
    );
  }
}
