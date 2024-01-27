import 'package:shoppinglist/data/categories_data.dart';
import 'package:shoppinglist/models/category.dart';

class GroceryItem {
  GroceryItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.category});
  final String id;
  final String title;
  final int quantity;
  final Category category;
}

final groceryItems = [
  GroceryItem(
      id: 'a',
      title: 'Milk',
      quantity: 1,
      category: categories[Categories.dairy]!),
  GroceryItem(
      id: 'b',
      title: 'Bananas',
      quantity: 5,
      category: categories[Categories.fruit]!),
  GroceryItem(
      id: 'c',
      title: 'Beef Steak',
      quantity: 1,
      category: categories[Categories.meat]!),
];
