class Product {
  final int id;
  final String title;
  final String address;
  final String name;
  final String label;
  final double price;
  final String image;
  final String description;
  final String rating;
  final String duration;
  int quantity;
  bool isAdded;

  Product({
    required this.id,
    required this.title,
    required this.address,
    required this.name,
    required this.label,
    required this.price,
    required this.image,
    required this.rating,
    required this.duration,
    required this.description,
    this.quantity = 0,
    this.isAdded = false,
  });

  factory Product.fromJson(Map<String, dynamic> data) => Product(
        id: data['id'],
        title: data['title'],
        address: data['address'],
        name: data['name'],
        label: data['label'],
        price: double.parse(data['price'].toString()),
        image: data['image'],
        description: data['description'],
        rating: data['rating'],
        duration: data['duration'],
      );
  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'address': address,
        'name': name,
        'label': label,
        'price': price,
        'image': image,
        'description': description,
        'rating': rating,
        'duration': duration,
      };
}
