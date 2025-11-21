import 'package:flutter/material.dart';
import '../models/produk.dart';
import '../blocs/cart_cubit.dart';

/// A simple product card that displays the product image inside a Card.
///
/// The widget will try to load the image as network image when the
/// `produk.image` looks like a URL (starts with http/https), otherwise
/// it will fall back to `Image.asset`. If no image is provided a
/// placeholder is shown.
class ProductCard extends StatelessWidget {
  final Produk produk;
  final VoidCallback? onTap;
  /// Optional CartCubit instance. If provided, the card's add button will
  /// call `cart.addToCart(produk)` directly.
  final CartCubit? cart;
  /// Optional callback called when the add-to-cart button is pressed.
  /// If both [cart] and [onAdd] are provided, [cart] takes precedence.
  final void Function(Produk)? onAdd;

  const ProductCard({
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
            // image area
            AspectRatio(
              aspectRatio: 16 / 9,
              child: _buildImage(),
            ),

            // name & price area
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    produk.nama,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rp ${produk.price}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      // Add to cart button
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
      return Container(
        color: Colors.grey[200],
        child: const Center(
          child: Icon(Icons.image, size: 40, color: Colors.black38),
        ),
      );
    }

    if (_isNetwork(img)) {
      return Image.network(
        img,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Container(
            color: Colors.grey[200],
            child: const Center(child: CircularProgressIndicator()),
          );
        },
        errorBuilder: (context, error, stackTrace) => Container(
          color: Colors.grey[200],
          child: const Center(
            child: Icon(Icons.broken_image, size: 40, color: Colors.black38),
          ),
        ),
      );
    }

    // treat as asset path
    return Image.asset(
      img,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        color: Colors.grey[200],
        child: const Center(
          child: Icon(Icons.broken_image, size: 40, color: Colors.black38),
        ),
      ),
    );
  }
}
