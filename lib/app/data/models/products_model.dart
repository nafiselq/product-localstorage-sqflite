class Product {
  final int? id;
  final String name;
  final String description;
  final int qty;
  final int price;

  const Product({
    this.id,
    required this.name,
    required this.description,
    required this.qty,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        qty: json['qty'],
        price: json['price'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'qty': qty,
        'price': price,
      };
}
