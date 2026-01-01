import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/category.dart';
import '../services/category_service.dart';

final categoryServiceProvider = Provider((ref) => CategoryService());

// Get all categories
final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final service = ref.watch(categoryServiceProvider);
  return service.getAllCategories();
});

// Get a category by ID
final categoryByIdProvider =
    FutureProvider.family<Category?, int>((ref, categoryId) async {
  final service = ref.watch(categoryServiceProvider);
  return service.getCategoryById(categoryId);
});
