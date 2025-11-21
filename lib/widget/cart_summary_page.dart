import 'package:flutter/material.dart';
import '../blocs/cart_cubit.dart';
import '../models/produk.dart';

/// A simple page that shows cart totals (total items and total price).
/// It listens to the provided [CartCubit] for realtime updates.
class CartSummaryPage extends StatelessWidget {
  final CartCubit cart;

  const CartSummaryPage({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Summary'),
      ),
      body: AnimatedBuilder(
        animation: cart,
        builder: (context, _) {
          final totalItems = cart.getTotalItems();
          final totalPrice = cart.getTotalPrice();

          // build unique product list
          final List<Produk> uniqueProducts = [];
          for (final p in cart.items) {
            if (!uniqueProducts.any((u) => u.id == p.id)) uniqueProducts.add(p);
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // totals header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Total Items', style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        Text('$totalItems', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text('Total Price', style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        Text('Rp $totalPrice', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // list of products with qty controls
                if (uniqueProducts.isEmpty)
                  const Expanded(
                    child: Center(child: Text('Cart is empty')),
                  )
                else
                  Expanded(
                    child: ListView.separated(
                      itemCount: uniqueProducts.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final p = uniqueProducts[index];
                        final qty = cart.quantityOf(p);
                        final subtotal = qty * p.price;

                        return ListTile(
                          leading: _buildThumb(p),
                          title: Text(p.nama),
                          subtitle: Text('Rp ${p.price}  •  Subtotal: Rp $subtotal'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed: qty > 0
                                    ? () => cart.updateQuantity(p, qty - 1)
                                    : null,
                              ),
                              Text('$qty'),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed: () => cart.updateQuantity(p, qty + 1),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                const SizedBox(height: 8),
                // Checkout button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: totalItems > 0
                          ? () {
                              cart.clear();
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cart cleared')));
                            }
                          : null,
                      child: const Text('Checkout'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildThumb(Produk produk) {
    final img = produk.image.trim();
    if (img.isEmpty) {
      return Container(
        width: 56,
        height: 56,
        color: Colors.grey[200],
        child: const Icon(Icons.image, color: Colors.black38),
      );
    }

    final isNetwork = img.toLowerCase().startsWith('http://') || img.toLowerCase().startsWith('https://');
    if (isNetwork) {
      return Image.network(img, width: 56, height: 56, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(width:56,height:56,color:Colors.grey[200],child:const Icon(Icons.broken_image)));
    }

    return Image.asset(img, width: 56, height: 56, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(width:56,height:56,color:Colors.grey[200],child:const Icon(Icons.broken_image)));
  }
}
