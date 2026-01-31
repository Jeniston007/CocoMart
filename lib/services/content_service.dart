import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/banner_model.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

class ContentService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<BannerModel>> fetchBanners() async {
    final snapshot = await _db
        .collection('banners')
        .where('isActive', isEqualTo: true)
        .get();
    return snapshot.docs.map((e) => BannerModel.fromSnapshot(e)).toList();
  }

  Future<List<CategoryModel>> fetchCategories() async {
    final snapshot = await _db.collection('categories').limit(10).get();
    return snapshot.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
  }

  Future<List<Product>> fetchPopularProducts() async {
    final snapshot = await _db
        .collection('products')
        .where('isPopular', isEqualTo: true)
        .limit(6)
        .get();
    return snapshot.docs.map((e) => Product.fromSnapshot(e)).toList();
  }

  Future<List<Product>> fetchFeaturedProducts() async {
    final snapshot = await _db
        .collection('products')
        .where('isFeatured', isEqualTo: true)
        .limit(6)
        .get();
    return snapshot.docs.map((e) => Product.fromSnapshot(e)).toList();
  }
}
