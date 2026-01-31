import 'package:get/get.dart';
import '../services/content_service.dart';
import '../models/product_model.dart';
import '../models/category_model.dart';
import '../models/banner_model.dart';

class HomeController extends GetxController {
  final ContentService _contentService = ContentService();

  final RxList<BannerModel> banners = <BannerModel>[].obs;
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxList<Product> popularProducts = <Product>[].obs;
  final RxList<Product> featuredProducts = <Product>[].obs;

  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllData();
  }

  Future<void> fetchAllData() async {
    try {
      isLoading.value = true;
      await Future.wait([fetchBanners(), fetchCategories(), fetchProducts()]);
    } catch (e) {
      print("Error fetching home data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchBanners() async {
    banners.value = await _contentService.fetchBanners();
  }

  Future<void> fetchCategories() async {
    categories.value = await _contentService.fetchCategories();
  }

  Future<void> fetchProducts() async {
    final popular = await _contentService.fetchPopularProducts();
    final featured = await _contentService.fetchFeaturedProducts();

    popularProducts.value = popular;
    featuredProducts.value = featured;
  }
}
