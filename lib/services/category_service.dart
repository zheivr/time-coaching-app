import '../models/category.dart';
import '../repositories/category_repository.dart';

class CategoryService {
  final CategoryRepository _repository = CategoryRepository();

  /// Get all active categories
  Future<List<Category>> getAllCategories() async {
    return await _repository.getAllCategories();
  }

  /// Get a category by ID
  Future<Category?> getCategoryById(int id) async {
    return await _repository.getCategoryById(id);
  }

  /// Add a new category
  Future<void> addCategory(Category category) async {
    await _repository.insertCategory(category);
  }

  /// Update a category
  Future<void> updateCategory(Category category) async {
    await _repository.updateCategory(category);
  }

  /// Delete a category
  Future<void> deleteCategory(int id) async {
    await _repository.deleteCategory(id);
  }
}
