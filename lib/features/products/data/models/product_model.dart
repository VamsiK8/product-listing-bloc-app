class Product {
  final int id;
  final String title;
  final String description;
  final String image;
  final double price;
  final double rating;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      image: map['image'],
      price: map['price'].toDouble(),
      rating: map['rating']['rate'].toDouble(),
    );
  }
}
