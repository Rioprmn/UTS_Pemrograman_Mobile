// Model Produk (moved from produk.dart)
class Produk {
  final String id;
  final String nama;
  final int price;
  final String image;

  const Produk({
    required this.id,
    required this.nama,
    required this.price,
    required this.image,
  });

  Produk copyWith({String? id, String? nama, int? price, String? image}) {
    return Produk(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      price: price ?? this.price,
      image: image ?? this.image,
    );
  }

  factory Produk.fromJson(Map<String, dynamic> json) {
    return Produk(
      id: json['id'] as String? ?? '',
      nama: json['nama'] as String? ?? '',
      price: json['price'] is int
          ? json['price'] as int
          : (json['price'] is String ? int.tryParse(json['price']) ?? 0 : 0),
      image: json['image'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'price': price,
      'image': image,
    };
  }

  /// Convert this Produk to a Map (String -> dynamic).
  Map<String, dynamic> toMap() => toJson();

  /// Create a Produk from a Map (String -> dynamic).
  factory Produk.fromMap(Map<String, dynamic> map) {
    return Produk(
      id: map['id'] as String? ?? '',
      nama: map['nama'] as String? ?? '',
      price: map['price'] is int
          ? map['price'] as int
          : (map['price'] is String ? int.tryParse(map['price']) ?? 0 : 0),
      image: map['image'] as String? ?? '',
    );
  }

  @override
  String toString() => 'Produk(id: $id, nama: $nama, price: $price, image: $image)';
}
