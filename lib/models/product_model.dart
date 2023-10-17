class Product {
  final String image;
  final String name;
  final String location;
  final double rating;
  final int reviews;
  final double price;

  Product({
    required this.image,
    required this.name,
    required this.location,
    required this.rating,
    required this.reviews,
    required this.price,
  });
}


class ProductCategory {
  final String name;
  final String imageUrl;

  ProductCategory({
    required this.name,
    required this.imageUrl,
  });
}



class CartItem {
  final Product product;

  CartItem({required this.product});
}
