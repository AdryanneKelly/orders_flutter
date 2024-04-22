import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final String image;
  final String category;
  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
  });

  ProductModel copyWith({
    int? id,
    String? title,
    String? description,
    double? price,
    String? image,
    String? category,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      image: image ?? this.image,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'image': image,
      'category': category,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      price: map['price'] as double,
      image: map['image'] as String,
      category: map['category'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(id: $id, title: $title, description: $description, price: $price, image: $image, category: $category)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.price == price &&
        other.image == image &&
        other.category == category;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ description.hashCode ^ price.hashCode ^ image.hashCode ^ category.hashCode;
  }
}
