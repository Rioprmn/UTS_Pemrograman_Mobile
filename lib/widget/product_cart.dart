import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../blocs/cart_cubit.dart';

/// Product card widget (moved/renamed)
class ProductCart extends StatelessWidget {
  final Produk produk;
  final VoidCallback? onTap;
  final CartCubit? cart;
  final void Function(Produk)? onAdd;

  const ProductCart({
    super.key,
    required this.produk,
    this.onTap,
    this.cart,
    this.onAdd,
  });

  bool _isNetwork(String url) {
    final lower = url.toLowerCase();
    return lower.startsWith('http://') || lower.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(aspectRatio: 16 / 9, child: _buildImage()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    produk.nama,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Rp ${produk.price}', style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (cart != null) {
                            cart!.addToCart(produk);
                          } else if (onAdd != null) {
                            onAdd!(produk);
                          }
                        },
                        icon: const Icon(Icons.add_shopping_cart),
                        label: const Text('Add'),
                        style: ElevatedButton.styleFrom(elevation: 0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    final img = produk.image.trim();
    if (img.isEmpty) {
      return Container(color: Colors.grey[200], child: const Center(child: Icon(Icons.image, size: 40, color: Colors.black38)));
    }
    if (_isNetwork(img)) {
      return Image.network(img, fit: BoxFit.cover, loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(color: Colors.grey[200], child: const Center(child: CircularProgressIndicator()));
      }, errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[200], child: const Center(child: Icon(Icons.broken_image, size: 40, color: Colors.black38)))) ;
    }
    return Image.asset(img, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[200], child: const Center(child: Icon(Icons.broken_image, size: 40, color: Colors.black38))));
  }
}
