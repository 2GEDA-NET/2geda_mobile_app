import 'package:_2geda/models/product_model.dart';

List<Product> productList = [
  Product(
    image:
        'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
    name: 'Product 1',
    rating: 4.5,
    reviews: 100,
    location: 'Lekki, Lagos',
    price: 49.99,
  ),
  Product(
    image:
        'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
    name: 'Product 1',
    rating: 4.5,
    location: 'Lekki, Lagos',
    reviews: 100,
    price: 49.99,
  ),
  Product(
    image:
        'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
    name: 'Product 1',
    rating: 4.5,
    location: 'Lekki, Lagos',
    reviews: 100,
    price: 49.99,
  ),
  Product(
    image:
        'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
    name: 'Product 1',
    rating: 4.5,
    reviews: 100,
    location: 'Lekki, Lagos',
    price: 49.99,
  ),
  // Add more products here...
];

List<ProductCategory> productCategories = [
  ProductCategory(
    name: 'Electronics',
    imageUrl:
        'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
  ),
  ProductCategory(
    name: 'Clothing',
    imageUrl:
        'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
  ),
  ProductCategory(
    name: 'Home Decor',
    imageUrl:
        'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
  ),
  ProductCategory(
    name: 'Electronics',
    imageUrl:
        'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
  ),
  ProductCategory(
    name: 'Clothing',
    imageUrl:
        'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
  ),
  ProductCategory(
    name: 'Home Decor',
    imageUrl:
        'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
  ),
  ProductCategory(
    name: 'Electronics',
    imageUrl:
        'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
  ),
  ProductCategory(
    name: 'Clothing',
    imageUrl:
        'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
  ),
  ProductCategory(
    name: 'Home Decor',
    imageUrl:
        'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
  ),
  // Add more categories as needed
];

// Replace this with your actual data model
List<CartItem> cartItems = [
  CartItem(
    product: Product(
      image:
          'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
      name: 'Product 1',
      rating: 4.5,
      location: 'Lekki, Lagos',
      reviews: 100,
      price: 49.99,
    ),
  ),
  CartItem(
    product: Product(
      image:
          'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
      name: 'Product 1',
      rating: 4.5,
      location: 'Lekki, Lagos',
      reviews: 100,
      price: 49.99,
    ),
  ),
  CartItem(
    product: Product(
      image:
          'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
      name: 'Product 1',
      rating: 4.5,
      location: 'Lekki, Lagos',
      reviews: 100,
      price: 49.99,
    ),
  ),
  CartItem(
    product: Product(
      image:
          'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
      name: 'Product 1',
      rating: 4.5,
      location: 'Lekki, Lagos',
      reviews: 100,
      price: 49.99,
    ),
  ),
  CartItem(
    product: Product(
      image:
          'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
      name: 'Product 1',
      rating: 4.5,
      location: 'Lekki, Lagos',
      reviews: 100,
      price: 49.99,
    ),
  ),
  CartItem(
    product: Product(
      image:
          'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
      name: 'Product 1',
      rating: 4.5,
      location: 'Lekki, Lagos',
      reviews: 100,
      price: 49.99,
    ),
  ),
  CartItem(
    product: Product(
      image:
          'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
      name: 'Product 1',
      rating: 4.5,
      location: 'Lekki, Lagos',
      reviews: 100,
      price: 49.99,
    ),
  ),
];
